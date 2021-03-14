import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontStyles {
  /// AbrilFatface with default font size of 12 and font weight normal / plain / regular
  static TextStyle abrilFatface(
          {@required Color color,
          double letterSpacing = 0.0,
          double fontSize = 12.0,
          FontWeight fontWeight = FontWeight.w400}) =>
      GoogleFonts.abrilFatface(
          color: color,
          fontWeight: fontWeight,
          fontStyle: FontStyle.normal,
          letterSpacing: letterSpacing,
          fontSize: fontSize);

  /// inter with default font size of 12 and font weight normal / plain / regular
  static TextStyle inter(
          {@required Color color,
          double letterSpacing = 0.0,
          double fontSize = 12.0,
          FontWeight fontWeight = FontWeight.w400,
          double height = 1}) =>
      GoogleFonts.inter(
          color: color,
          fontWeight: fontWeight,
          fontStyle: FontStyle.normal,
          letterSpacing: letterSpacing,
          fontSize: fontSize,
          height: height);
}
