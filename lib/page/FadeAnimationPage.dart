import 'package:flutter/material.dart';
import '../constants/Dimens.dart';

class FadeAnimationPage extends StatefulWidget {
  final title;
  FadeAnimationPage({this.title});
  @override
  createState() => _FadeAnimationState(title: title);
}

class _FadeAnimationState extends State<FadeAnimationPage>
    with TickerProviderStateMixin {
  final title;

  AnimationController controller;
  CurvedAnimation curve;
  bool isShowing = false;

  _FadeAnimationState({this.title});

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: Dimens.ELEVATION_TITLE,
      ),
      body: Center(
        child: Container(
          child: FadeTransition(
            opacity: curve,
            child: FlutterLogo(size: 100.0),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Fade',
        child: Icon(Icons.brush),
        onPressed: () {
          isShowing ? controller.reverse() : controller.forward();
          setState(() => isShowing = !isShowing);
        },
      ),
    );
  }
}
