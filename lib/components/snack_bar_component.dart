import 'package:flutter/material.dart';
import 'package:lichtline/components/text_component.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';

class SnackbarComponent {
  static snackbar(String message, GlobalKey<ScaffoldState> scaffoldKey) {
    final snackBar = new SnackBar(
      content: new TextComponent(
        text: message,
        textStyle: FontStyles.inter(color: ColorConstant.white, fontSize: 14),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
