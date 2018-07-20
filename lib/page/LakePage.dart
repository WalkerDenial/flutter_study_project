import 'package:flutter/material.dart';
import '../constants/Dimens.dart';

class LakePage extends StatelessWidget {
  final title;
  LakePage({this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: Dimens.elevationTitle,
      ),
      body: Image.asset(
        'images/lake.jpg',
        height: 240.0,
        fit: BoxFit.fitWidth,
      ),
      backgroundColor: Colors.red,
    );
  }
}
