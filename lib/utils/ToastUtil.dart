import 'package:fluttertoast/fluttertoast.dart';
import '../constants/Dimens.dart';

class ToastUtil {
  static int _lastTime = 0;
  static showToast(String msg) {
    if (msg.isEmpty) return;
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    if (currentTime - _lastTime <= Dimens.durationToast) return;
    _lastTime = currentTime;
    Fluttertoast.showToast(
      msg: '  $msg  ',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1
    );
  }
}
