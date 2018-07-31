import 'package:flutter/material.dart';
import '../constants/Dimens.dart';

class ColorsPage extends StatelessWidget {
  final title;
  ColorsPage({this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: Dimens.elevationTitle,
      ),
      body: Text(title),
    );
  }
}
