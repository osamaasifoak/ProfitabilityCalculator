import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextComponent extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final TextStyle textStyle;
  final int maxLines;
  final TextOverflow overflow;
  const TextComponent(
      {Key key,
      @required this.text,
      this.textAlign = TextAlign.left,
      this.textStyle,
      this.maxLines,
      this.overflow})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: textStyle != null
            ? textStyle
            : GoogleFonts.heebo(
                fontSize: 12, color: ColorConstant.greyishBrownThree));
  }
}
