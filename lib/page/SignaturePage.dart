import 'package:flutter/material.dart';
import 'package:flutter_statusbar/flutter_statusbar.dart';
import 'dart:io' show Platform;
import '../constants/Dimens.dart';

double statusBarHeight, appBarHeight;

class SignaturePage extends StatefulWidget {
  final title;
  SignaturePage({this.title}) {
    initPlatformState();
  }
  createState() => _SignatureState(title: title);
  initPlatformState() async {
    try {
      statusBarHeight = await FlutterStatusbar.height;
    } on Exception {
      statusBarHeight = 0.0;
    }
  }
}

class _SignatureState extends State<SignaturePage> {
  final title;
  List<Offset> _points = <Offset>[];
  _SignatureState({this.title});
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text(title),
      elevation: Dimens.ELEVATION_TITLE,
    );
    appBarHeight = appBar.preferredSize.height;
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: SizedBox.expand(
          child: GestureDetector(
            onPanUpdate: (details) => setState(() {
                  RenderBox referenceBox = context.findRenderObject();
                  Offset localPosition =
                      referenceBox.globalToLocal(details.globalPosition);
                  _points = List.from(_points)
                    ..add(localPosition -
                        Offset(
                            0.0,
                            Platform.isAndroid
                                ? statusBarHeight
                                : (statusBarHeight + appBarHeight)));
                }),
            onPanEnd: (details) => _points.add(null),
            child: CustomPaint(painter: SignaturePainter(_points)),
          ),
        ),
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  SignaturePainter(this.points);
  final List<Offset> points;
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  bool shouldRepaint(SignaturePainter other) => other.points != points;
}
