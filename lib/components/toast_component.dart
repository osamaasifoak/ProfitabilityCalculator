import 'package:fluttertoast/fluttertoast.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';

class ToastComponent {
  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorConstant.greyishBrownThree,
        textColor: ColorConstant.white,
        fontSize: 16.0);
  }
}
