import 'package:flutter/material.dart';

class SnackbarUtils {
  static showInSnackBar(String value, scaffoldKey) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }
}
