import 'package:flutter/material.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';

class PopupLoader {
  static showLoadingDialog(context, {String message}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => true,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 8,
                    backgroundColor: ColorConstant.white,
                  ),
                ),
                SizedBox(height: 10),
                // TextWidgets.titleSecondaryThemeColor(
                //     message != null ? message : "", 14)
              ],
            )),
          );
        });
  }

  static hideLoadingDialog(context) {
    Navigator.pop(context);
  }
}
