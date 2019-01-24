import 'package:flutter/material.dart';
import '../constants/Dimens.dart';
import '../widgets/LineProgress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelfProgressBarPage extends StatelessWidget {
  final title;
  SelfProgressBarPage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          elevation: Dimens.ELEVATION_TITLE,
        ),
        body: Container(
          color: Colors.grey,
          child: Container(
            height: 36,
            width: ScreenUtil.screenWidth,
            margin: EdgeInsets.only(left: 20, right: 20),
            color: Colors.white,
            child: LineProgress(51),
          ),
          alignment: Alignment.center,
        ));
  }
}
