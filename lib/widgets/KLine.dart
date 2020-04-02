import 'dart:ui';
import 'dart:ui' as ui show TextStyle;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:study_project/utils/ToastUtil.dart';

class KLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(child: CustomPaint(painter: _KLinePainter()));
}

class _KLinePainter extends CustomPainter {
  Paint _paint;
  Path _borderPath;
  List<Path> _dashList = [];
  double _width;
  double _minOffset = 10;
  double _maxOffset = 310;
  double _spaceX, _spaceY;
  Paragraph _paragraph;
  TextPainter _textPainter;
  _KLinePainter() {
    _initData();
  }

  void _initData() {
    _paint = Paint()
      ..color = Color.fromARGB(80, 12, 12, 12)
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    _width = ScreenUtil.screenWidthDp - 100;

    _spaceX = (_width - _minOffset) / 4;
    _spaceY = (_maxOffset - _minOffset) / 4;

    _borderPath = Path()
      ..fillType = PathFillType.nonZero
      ..moveTo(_minOffset, _minOffset)
      ..lineTo(_width, _minOffset)
      ..lineTo(_width, _maxOffset)
      ..lineTo(_minOffset, _maxOffset)
      ..close();

    for (int i = 1; i < 4; i++) {
      _dashList.add(Path()
        ..moveTo(_minOffset, _minOffset + _spaceY * i)
        ..lineTo(_width, _minOffset + _spaceY * i));
      _dashList.add(Path()
        ..moveTo(_minOffset + _spaceX * i, _minOffset)
        ..lineTo(_minOffset + _spaceX * i, _maxOffset));
    }

    // 第一种绘制文字方式
    _textPainter = TextPainter(
        text: TextSpan(
          text: '1234',
          style: TextStyle(
              fontSize: 20,
              color: Colors.red,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.start);

    // 第二种绘制文字方式
    ParagraphBuilder _builder = ParagraphBuilder(ParagraphStyle(
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.normal,
        fontSize: 20))
      ..pushStyle(ui.TextStyle(color: Colors.red))
      ..addText("1234");

    _paragraph = _builder.build()..layout(ParagraphConstraints(width: 45));
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制边框
    canvas.drawPath(_borderPath, _paint);

    for (int i = 0; i < _dashList.length; i++)
      canvas.drawPath(
          dashPath(_dashList[i],
              dashArray: CircularIntervalList<double>(<double>[3.0, 5.0])),
          _paint);

    canvas.drawParagraph(_paragraph, Offset(20, 20));

    _textPainter
      ..layout(maxWidth: 100, minWidth: 10)
      ..paint(canvas, Offset(50, 50));

    // 测量文本框大小
    ToastUtil.showToast("${_textPainter.size}");
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
