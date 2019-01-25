import 'package:flutter/material.dart';
import '../constants/Dimens.dart';
import '../widgets/LineProgress.dart';

class SelfProgressBarPage extends StatefulWidget {
  final title;
  SelfProgressBarPage({this.title});
  @override
  State<StatefulWidget> createState() => _SelfProgressBarState(title: title);
}

class _SelfProgressBarState extends State<SelfProgressBarPage> {
  final title;
  int _progress;
  _SelfProgressBarState({this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          elevation: Dimens.ELEVATION_TITLE,
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: TextField(
                onSubmitted: (text) => setState(() => _progress =
                    isProgressAvaliable(text) ? int.parse(text) : 0),
                decoration: InputDecoration(
                    hintText: '请输入进度', errorText: "进度必须在0~100之间"),
                keyboardType: TextInputType.number,
              ),
              margin: EdgeInsets.only(left: 20, top: 20, right: 20),
            ),
            Container(
              height: 36,
              margin: EdgeInsets.all(20),
              child: LineProgress(_progress),
            )
          ],
        ));
  }

  bool isProgressAvaliable(String nums) =>
      RegExp(r"(0|[1-9]|[1-9]\\d|100)").hasMatch(nums);
}
