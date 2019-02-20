import 'package:flutter/material.dart';
import '../constants/Dimens.dart';
import '../widgets/NounWidget.dart';

class NounPage extends StatefulWidget {
  final title;
  NounPage({this.title});
  @override
  _NounPageState createState() => _NounPageState(title: title);
}

class _NounPageState extends State<NounPage>
    with SingleTickerProviderStateMixin {
  final title;
  _NounPageState({this.title});
  AnimationController _controller;
  Animation<double> _animation;
  double _value = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _animation = Tween(begin: 0.0, end: 100.0).animate(_controller)
      ..addListener(_animationListener);
    _controller.forward();
  }

  _animationListener() {
    setState(() {
      _value = _animation.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: Dimens.ELEVATION_TITLE,
      ),
      body: NounWidget(_value.toStringAsFixed(2)),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }
}
