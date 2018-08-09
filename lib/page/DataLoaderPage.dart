import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:isolate';
import '../constants/Dimens.dart';

class DataLoaderPage extends StatelessWidget {
  final title;
  DataLoaderPage({this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: Dimens.elevationTitle,
      ),
      body: _ChildWidget(),
    );
  }
}

class _ChildWidget extends StatefulWidget {
  @override
  createState() => _ChildWidgetState();
}

class _ChildWidgetState extends State<_ChildWidget> {
  List widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  showLoadingDialog() => widgets.length == 0;

  getBody() => showLoadingDialog() ? getProgressDialog() : getListView();

  getProgressDialog() => Center(child: CircularProgressIndicator());

  @override
  build(context) => getBody();

  ListView getListView() => ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (context, position) => getRow(position),
      );

  getRow(i) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('Row ${widgets[i]['title']}'),
          ),
          Divider(height: Dimens.divideHeight),
        ],
      );

  loadData() async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(dataloader, receivePort.sendPort);

    SendPort sendPort = await receivePort.first;

    List msg = await sendReceive(
        sendPort, 'https://jsonplaceholder.typicode.com/posts');

    setState(() => widgets = msg);
  }

  static dataloader(SendPort sendPort) async {
    ReceivePort port = ReceivePort();
    sendPort.send(port.sendPort);
    await for (var msg in port) {
      String date = msg[0];
      SendPort replyTo = msg[1];

      String dataURL = date;
      http.Response response = await http.get(dataURL);
      replyTo.send(jsonDecode(response.body));
    }
  }

  Future sendReceive(SendPort port, msg) {
    ReceivePort response = ReceivePort();
    port.send([msg, response.sendPort]);
    return response.first;
  }
}
