import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lichtline/components/text_component.dart';
import 'package:lichtline/constants/assets/assets_constants.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';

class ReviewStars extends StatelessWidget {
  final int starCount;
  final String rating;
  final Color textColor;
  final double starSize;
  final double paddingRight;
  final bool isRateReview;
  final int ratedStar;
  final Function(int i) onTapForRatingStar;
  const ReviewStars({
    Key key,
    this.starCount = 0,
    this.rating,
    this.textColor = ColorConstant.white,
    this.starSize = 12.0,
    this.paddingRight = 0.0,
    this.isRateReview = false,
    this.ratedStar = 1,
    this.onTapForRatingStar,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return isRateReview ? _rateReviewStars() : _showOnlyStars();
  }

  Row _rateReviewStars() {
    return Row(
      children: [
        for (var i = 1; i <= starCount; i++)
          InkWell(
            onTap: () {
              onTapForRatingStar(i);
            },
            child: Padding(
              padding: EdgeInsets.only(right: paddingRight),
              child: SvgPicture.asset(
                AssetConstant.star,
                color: ratedStar >= i
                    ? ColorConstant.mango
                    : ColorConstant.veryLightPinkTwo,
                height: starSize,
                width: starSize,
              ),
            ),
          ),
        rating != null
            ? Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextComponent(
                  text: rating,
                  textStyle: FontStyles.inter(
                      color: textColor, fontSize: 14, letterSpacing: -0.17),
                  textAlign: TextAlign.left,
                ),
              )
            : SizedBox(),
      ],
    );
  }

  Row _showOnlyStars() {
    return Row(
      children: [
        for (var i = 0; i < starCount; i++)
          Padding(
            padding: EdgeInsets.only(right: paddingRight),
            child: SvgPicture.asset(
              AssetConstant.star,
              color: ColorConstant.mustard,
              height: starSize,
              width: starSize,
            ),
          ),
        rating != null
            ? Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextComponent(
                  text: rating,
                  textStyle: FontStyles.inter(
                      color: textColor, fontSize: 14, letterSpacing: -0.17),
                  textAlign: TextAlign.left,
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
