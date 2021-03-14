import 'package:lichtline/components/text_component.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomListTileComponent extends StatelessWidget {
  final bool isLeading, isTrailing, isTitle;
  final String title, trailingImage, leadingImage;
  final Color backGroundColor, leadingIconColor, trailingIconColor;
  final double borderRadiusTopLeft,
      borderRadiusTopRight,
      borderRadiusBottomLeft,
      borderRadiusBottomRight;

  const CustomListTileComponent({
    Key key,
    this.isLeading = true,
    this.isTrailing = true,
    this.isTitle = true,
    this.title = "",
    this.trailingImage = "",
    this.leadingImage = "",
    this.borderRadiusTopLeft = 5.0,
    this.borderRadiusTopRight = 5.0,
    this.borderRadiusBottomLeft = 5.0,
    this.borderRadiusBottomRight = 5.0,
    this.backGroundColor = ColorConstant.white,
    this.leadingIconColor = ColorConstant.black,
    this.trailingIconColor = ColorConstant.black,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadiusTopLeft),
          topRight: Radius.circular(borderRadiusTopRight),
          bottomRight: Radius.circular(borderRadiusBottomRight),
          bottomLeft: Radius.circular(borderRadiusBottomLeft),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Visibility(
                  visible: isLeading,
                  child: SvgPicture.asset(
                    leadingImage,
                    color: leadingIconColor,
                    width: 18,
                    height: 16,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Visibility(
                  visible: isTitle,
                  child: TextComponent(
                    text: title,
                    textStyle: FontStyles.inter(
                        color: ColorConstant.greyishBrownTwo, fontSize: 14),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Visibility(
              visible: isTrailing,
              child: SvgPicture.asset(trailingImage, color: trailingIconColor),
            ),
          ],
        ),
      ),
    );
  }
}
