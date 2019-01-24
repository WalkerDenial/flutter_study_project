import 'package:flutter/material.dart';
import '../constants/Dimens.dart';

class LineProgress extends StatelessWidget {
  final int progress;
  final int lineCounts;
  LineProgress(this.progress, {Key key, this.lineCounts}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: CustomPaint(
              painter: SelfProgressPainter(
                progress: _progress,
                linesCounts: _lineCounts,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  '$_progress%',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  int get _progress {
    if (progress == null)
      return Dimens.DEFAULT_PROGRESS;
    else if (progress < Dimens.MIN_PROGRESS)
      return Dimens.MIN_PROGRESS;
    else if (progress > Dimens.MAX_PROGRESS)
      return Dimens.MAX_PROGRESS;
    else
      return progress;
  }

  int get _lineCounts {
    if (lineCounts == null)
      return Dimens.DEFAULT_LINE_COUNTS;
    else if (lineCounts < Dimens.MIN_LINE_COUNTS)
      return Dimens.MIN_LINE_COUNTS;
    else if (lineCounts > Dimens.MAX_LINE_COUNTS)
      return Dimens.MAX_LINE_COUNTS;
    else
      return lineCounts;
  }
}

class SelfProgressPainter extends CustomPainter {
  final int progress;
  final int linesCounts;
  final double _lineStoke = 1.0;
  double _spaceWidth;
  double _progressWidth;
  List<Offset> _lineLists, _subLineLists;
  SelfProgressPainter({this.progress, this.linesCounts});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = _lineStoke;

    _lineLists = _calcLineLists(size.width, size.height);
    for (int i = 0; i < _lineLists?.length; i += 2) {
      canvas.drawLine(_lineLists[i], _lineLists[i + 1], paint);
    }

    _lineLists.first = Offset(-_spaceWidth, 0);
    _lineLists.last = Offset(size.width + _spaceWidth, size.height);
    _progressWidth = size.width * progress / Dimens.MAX_PROGRESS;
    _subLineLists = _calcSubLineLists(_progressWidth, size.height);
    for (int i = 0; i < _subLineLists?.length; i += 2) {
      canvas.drawLine(_subLineLists[i], _subLineLists[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(SelfProgressPainter old) => old.progress != progress;

  List<Offset> _calcLineLists(double width, double height) {
    _spaceWidth = (width - linesCounts * _lineStoke) / (linesCounts - 1);
    List<Offset> lists = <Offset>[];
    for (int i = 0; i < linesCounts * 2; i += 2) {
      double tempX = (_spaceWidth + _lineStoke) * i / 2.0;
      double x1 = tempX - _spaceWidth;
      double x2 = tempX + _spaceWidth;
      double y1 = 0;
      double y2 = height;
      if (x1 < 0) {
        lists.add(Offset(0, y2 - (x2 - 0) * height / 2 / _spaceWidth));
      } else {
        lists.add(Offset(x1, y1));
      }
      if (x2 > width) {
        lists.add(Offset(width, y2 - (x2 - width) * y2 / 2 / _spaceWidth));
      } else {
        lists.add(Offset(x2, y2));
      }
    }
    return lists;
  }

  List<Offset> _calcSubLineLists(double width, double height) {
    List<Offset> lists = <Offset>[];
    if (progress <= Dimens.MIN_PROGRESS) return lists;
    double _subSpaceWidth =
        (_spaceWidth - Dimens.DEFAULT_SUB_LINE_COUNTS * _lineStoke) /
            (Dimens.DEFAULT_SUB_LINE_COUNTS + 1);
    for (int i = 0; i < _lineLists?.length; i += 2) {
      if ((_lineLists[i].dx + _lineStoke) >= width) break;
      for (int j = Dimens.DEFAULT_SUB_LINE_COUNTS; j > 0; j--) {
        double x1 = _lineLists[i].dx - j * (_subSpaceWidth + _lineStoke);
        double x2 = _lineLists[i + 1].dx - j * (_subSpaceWidth + _lineStoke);
        double y1 = 0;
        double y2 = _lineLists[1].dy;
        if (x1 < 0) {
          lists.add(Offset(0, y2 - (x2 - 0) * height / 2 / _spaceWidth));
        } else {
          lists.add(Offset(x1, y1));
        }
        if (x2 > width) {
          lists.add(Offset(width, y2 - (x2 - width) * y2 / 2 / _spaceWidth));
        } else {
          lists.add(Offset(x2, y2));
        }
      }
    }
    return lists;
  }
}
