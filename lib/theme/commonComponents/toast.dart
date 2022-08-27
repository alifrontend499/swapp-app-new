// toast
import 'package:fluttertoast/fluttertoast.dart';

// common consts
const String LENGTH_SHORT = 'short';
const double DEFAULT_FONT_SIZE = 15;

void showFlutterToast(String msg, {String length = LENGTH_SHORT}) {
  // closing all other toasts
  Fluttertoast.cancel();

  Fluttertoast.showToast(
    msg: msg,
    fontSize: DEFAULT_FONT_SIZE,
    toastLength: length == LENGTH_SHORT ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
  );
}