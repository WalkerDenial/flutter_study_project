import 'package:flutter/material.dart';
import '../widgets/KLine.dart';
import '../constants/Dimens.dart';

class KLinePage extends StatelessWidget {
  final title;

  KLinePage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        elevation: Dimens.ELEVATION_TITLE,
      ),
      body: Container(
        child: KLine(),
      ),
    );
  }
  
}
