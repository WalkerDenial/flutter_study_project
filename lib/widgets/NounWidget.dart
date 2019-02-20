import 'package:flutter/material.dart';
import 'dart:math' as math;

class NounWidget extends StatelessWidget {
  final _value;
  NounWidget(this._value);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(painter: _NounPainter(double.parse(_value) / 100.0)),
    );
  }
}

class _NounPainter extends CustomPainter {
  final maxLength = 80.0;
  final minLength = 20.0;
  final lineWidth = 4.0;
  final lineCounts = 6;
  final middleValue = 0.5;
  double _value;
  double _minL, _maxL;
  Paint _paint;
  List<Offset> startOffsets = [];
  List<Offset> endOffsets = [];
  _NounPainter(this._value) {
    _initData();
  }

  void _initData() {
    _paint = Paint()
      ..color = Colors.orange
      ..strokeCap = StrokeCap.round
      ..strokeWidth = lineWidth;

    _minL = _calcMinLength();
    _maxL = _calcMaxLength();

    startOffsets.add(Offset(_calcDx(_minL), _minL / 2));
    startOffsets.add(Offset(0, _minL));
    startOffsets.add(Offset(-startOffsets[0].dx, startOffsets[0].dy));
    startOffsets.add(Offset(-startOffsets[0].dx, -startOffsets[0].dy));
    startOffsets.add(Offset(0, -_minL));
    startOffsets.add(Offset(startOffsets[0].dx, -startOffsets[0].dy));

    endOffsets.add(Offset(_calcDx(_maxL), _maxL / 2));
    endOffsets.add(Offset(0, _maxL));
    endOffsets.add(Offset(-endOffsets[0].dx, endOffsets[0].dy));
    endOffsets.add(Offset(-endOffsets[0].dx, -endOffsets[0].dy));
    endOffsets.add(Offset(0, -_maxL));
    endOffsets.add(Offset(endOffsets[0].dx, -endOffsets[0].dy));
  }

  double _calcMinLength() => _value < middleValue
      ? minLength
      : minLength + (maxLength - minLength) * (_value - middleValue) * 2;

  double _calcMaxLength() => _value >= middleValue
      ? maxLength
      : minLength + (maxLength - minLength) * _value * 2;

  double _calcDx(double value) => math.sqrt(value * value * 3 / 4);

  @override
  void paint(Canvas canvas, Size size) {
    if (_minL > minLength && (_minL + middleValue) >= _maxL) return;
    for (var i = 0; i < lineCounts; i++)
      canvas.drawLine(startOffsets[i], endOffsets[i], _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
