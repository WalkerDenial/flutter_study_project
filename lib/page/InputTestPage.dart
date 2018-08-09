import 'package:flutter/material.dart';
import '../constants/Dimens.dart';

class InputTestPage extends StatelessWidget {
  final title;
  InputTestPage({this.title});
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
  String _errorText;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        onSubmitted: (text) => setState(()=> _errorText = isEmail(text) ? null : 'Error: this is not an email'),
        decoration: InputDecoration(hintText: 'This is hint', errorText: _getErrorText()),
      ),
    );
  }

  _getErrorText() => _errorText;

  bool isEmail(String em) {
    String emailRegexp =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(emailRegexp);
    return regExp.hasMatch(em);
  }
}
