import 'package:flutter_svg/svg.dart';
import 'package:lichtline/components/text_component.dart';
import 'package:lichtline/constants/assets/assets_constants.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';
import 'package:flutter/material.dart';

class SimpleAppBarComponent extends StatelessWidget
    implements PreferredSizeWidget {
  final String imageTitle;
  final String title;
  final String subtile;
  final double height, bottomLeftRadius, bottomRightRadius;
  final Color color;
  final void Function() onTapBackButton;
  final bool isTrailingIcon;
  final String trailingIconName;
  final bool isBackButton;
  final bool isTitle;
  final TextStyle titleStyle;
  final bool isSubTitle;
  final TextStyle subTitleStyle;
  final String subTitle;
  final bool isImageTitle;
  final bool centerTitle;
  final void Function() onTapTrailingIcon;
  SimpleAppBarComponent(
      {this.title = "",
      this.imageTitle = "",
      this.height = 55.0,
      this.color = ColorConstant.white,
      this.bottomLeftRadius = 0.0,
      this.bottomRightRadius = 0.0,
      this.subtile = "",
      this.onTapBackButton,
      this.isTrailingIcon = false,
      this.isBackButton = true,
      this.isTitle = true,
      this.isImageTitle = false,
      this.titleStyle,
      this.centerTitle = false,
      this.isSubTitle = false,
      this.subTitleStyle,
      this.subTitle = "",
      this.onTapTrailingIcon,
      this.trailingIconName = AssetConstant.bell_icon});
  @override
  PreferredSize build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        color: ColorConstant.white,
        child: Container(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(bottomLeftRadius),
              bottomRight: Radius.circular(bottomRightRadius),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Visibility(
                          visible: isBackButton,
                          child: InkWell(
                            onTap: onTapBackButton != null
                                ? onTapBackButton
                                : () => {Navigator.pop(context)},
                            child: Icon(
                              Icons.arrow_back,
                              color: ColorConstant.greyishBrownThree,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: (isImageTitle == true) ? true : false,
                          child: Image.asset(
                            imageTitle,
                            height: 32,
                          ),
                        ),
                        Visibility(
                          visible: isTitle == true && centerTitle == false,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextComponent(
                              text: title,
                              textStyle: titleStyle != null
                                  ? titleStyle
                                  : FontStyles.inter(
                                      color: ColorConstant.greyishBrownTwo,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 24.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: centerTitle,
                      child: Padding(
                        padding:
                            EdgeInsets.only(right: isTrailingIcon ? 0.0 : 35.0),
                        child: Column(
                          children: [
                            TextComponent(
                              text: title,
                              textStyle: titleStyle != null
                                  ? titleStyle
                                  : FontStyles.inter(
                                      color: ColorConstant.greyishBrownTwo,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 24.0),
                            ),
                            Visibility(
                              visible: isSubTitle,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: TextComponent(
                                  text: subTitle,
                                  textStyle: subTitleStyle != null
                                      ? subTitleStyle
                                      : FontStyles.inter(
                                          color: ColorConstant.greyishBrownTwo,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isTrailingIcon,
                      child: InkWell(
                        enableFeedback: true,
                        onTap: onTapTrailingIcon,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: SvgPicture.asset(
                            trailingIconName,
                            color: ColorConstant.greyishBrownThree,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 23, top: 8),
                //   child: TextComponent(
                //     text: subtile,
                //     textStyle: FontStyles.abrilFatface(
                //         color: ColorConstant.black,
                //         fontSize: 10.0,
                //         fontWeight: FontWeight.w300),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(height);
}
