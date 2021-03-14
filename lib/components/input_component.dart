import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextInputComponent extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String action;
  final bool enabled, filled;
  final TextInputAction textInputAction;
  final FocusNode currentFocus, nextFocus;
  final Color fillColor;
  final String intialValue;
  final int maxLength;
  final ValueChanged<String> onChanged;
  final void Function(String) onFieldSubmitted;
  final String Function(String) validator;
  final Widget prefixIcon;
  final bool isEnableBorder;
  final bool isFocusBorder;
  final int maxLines;
  final int minLines;
  final Widget suffixIcon;
  final TextInputType keyboardType;
  const TextInputComponent({
    Key key,
    this.controller,
    @required this.title,
    this.action,
    this.enabled,
    this.textInputAction,
    this.currentFocus,
    this.nextFocus,
    this.maxLength,
    this.fillColor,
    this.onChanged,
    this.intialValue,
    this.filled,
    this.onFieldSubmitted,
    this.validator,
    this.prefixIcon,
    this.isEnableBorder = true,
    this.isFocusBorder = true,
    this.maxLines = 1,
    this.minLines = 1,
    this.suffixIcon,
    this.keyboardType = TextInputType.emailAddress,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        initialValue: intialValue,
        onChanged: onChanged,
        maxLength: maxLength != null ? maxLength : null,
        obscureText: false,
        enabled: this.enabled,
        focusNode: currentFocus,
        textInputAction: textInputAction,
        onFieldSubmitted: (value) {
          if (textInputAction == TextInputAction.next) {
            print(value + "callback");
            currentFocus.unfocus();
            FocusScope.of(context).requestFocus(nextFocus);
          }
        },
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: title,
          fillColor: fillColor,
          filled: filled,
          suffixIcon: suffixIcon,
          hintStyle: FontStyles.inter(color: ColorConstant.greyishBrownTwo),
          border: InputBorder.none,
          errorStyle: FontStyles.inter(color: ColorConstant.red),
          enabledBorder: isEnableBorder
              ? new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: new BorderSide(color: ColorConstant.brownGrey),
                )
              : null,
          focusedBorder: isFocusBorder
              ? new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: new BorderSide(
                    color: ColorConstant.black,
                  ),
                )
              : null,
        ),
        cursorColor: ColorConstant.black,
        maxLines: maxLines,
        minLines: minLines,
        style: FontStyles.inter(color: ColorConstant.greyishBrownTwo),
        validator: validator);
  }
}
