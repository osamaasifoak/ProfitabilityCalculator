import 'package:flutter/material.dart';
import 'package:lichtline/components/buttons/custom_container_button_component.dart';
import 'package:lichtline/components/review_star_component.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';

import '../text_component.dart';

class CustomCardListTileComponent extends StatelessWidget {
  final void Function() onTap;
  final int reviewStar;
  final bool isReviewStar;
  final bool isTrailingBtn;
  final String rideStatus, image, title, subTitle_1, subTitle_2;
  final bool showStarInsteadSubTitle;
  final Color btnColor;
  final Color btnTitleColor;
  final double btnHorizontalPadding;
  final bool showVerifiedBage;
  const CustomCardListTileComponent({
    Key key,
    this.onTap,
    this.rideStatus,
    this.image,
    this.title,
    this.subTitle_1,
    this.subTitle_2,
    this.reviewStar,
    this.isReviewStar = false,
    this.isTrailingBtn = true,
    this.showStarInsteadSubTitle = false,
    this.btnColor,
    this.btnTitleColor = ColorConstant.emerald,
    this.btnHorizontalPadding = 25,
    this.showVerifiedBage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 56,
          width: 56,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextComponent(
                text: title,
                textStyle: FontStyles.inter(
                    color: ColorConstant.brownGrey,
                    fontSize: 11,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  TextComponent(
                    text: subTitle_1 + "",
                    textStyle: FontStyles.inter(
                        color: ColorConstant.greyishBrownThree,
                        fontSize: 11,
                        fontWeight: FontWeight.w700),
                  ),
                  Visibility(
                    visible: showVerifiedBage,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, bottom: 1),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorConstant.emerald),
                        child: Icon(
                          Icons.check,
                          size: 10,
                          color: ColorConstant.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              showStarInsteadSubTitle
                  ? buildReviewStars()
                  : TextComponent(
                      text: subTitle_2,
                      textStyle: FontStyles.inter(
                          color: ColorConstant.greyishBrownThree,
                          fontSize: 11,
                          fontWeight: FontWeight.w700),
                    ),
            ],
          ),
        ),
        Visibility(
          visible: isReviewStar,
          child: Spacer(),
        ),
        Visibility(
          visible: isTrailingBtn,
          child: Flexible(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: _rideAndPaymentStatus(onTap, rideStatus),
            ),
          ),
        ),
        Visibility(
          visible: isReviewStar && showStarInsteadSubTitle == false,
          child: buildReviewStars(),
        )
      ],
    );
  }

  ReviewStars buildReviewStars() {
    return ReviewStars(
      starCount: reviewStar,
      rating: reviewStar.toString() + ".0",
      textColor: ColorConstant.greyishBrownTwo,
    );
  }

  Widget _rideAndPaymentStatus(void Function() onTap, String rideStatus) {
    return CustomContainerButtonComponent(
      text: rideStatus,
      onTap: onTap,
      horizontal: btnHorizontalPadding,
      color:
          btnColor != null ? btnColor : ColorConstant.emerald.withOpacity(0.2),
      textColor: btnTitleColor,
    );
  }
}
