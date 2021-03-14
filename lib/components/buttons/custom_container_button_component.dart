import 'package:flutter/material.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';

import '../text_component.dart';

class CustomContainerButtonComponent extends StatelessWidget {
  final void Function() onTap;
  final Color color;
  final String text;
  final Color textColor;
  final double horizontal;
  const CustomContainerButtonComponent(
      {Key key,
      this.onTap,
      this.text,
      this.color,
      this.textColor,
      this.horizontal = 25.0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: true,
      onTap: onTap,
      child: Container(
        decoration: new BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 8),
          child: TextComponent(
            text: text,
            textStyle: FontStyles.inter(
                color: textColor, fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
