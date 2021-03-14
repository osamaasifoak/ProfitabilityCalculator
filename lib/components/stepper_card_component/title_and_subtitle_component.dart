import 'package:flutter/material.dart';
import 'package:lichtline/components/text_component.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';

class TitleAndSubTitleComponent extends StatelessWidget {
  final String title, subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  const TitleAndSubTitleComponent({
    Key key,
    this.title,
    this.subTitle,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _amountDistanceAndCoveredColumn(title: title, subTitle: subTitle);
  }

  Column _amountDistanceAndCoveredColumn({String title, String subTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextComponent(
          text: title,
          textStyle: FontStyles.inter(
              color: ColorConstant.brownGrey,
              fontSize: 10,
              fontWeight: FontWeight.w700),
          maxLines: 3,
        ),
        SizedBox(
          height: 5,
        ),
        TextComponent(
          text: subTitle,
          textStyle: FontStyles.inter(
              color: ColorConstant.greyishBrownThree,
              fontSize: 13,
              fontWeight: FontWeight.w700),
          maxLines: 3,
        ),
      ],
    );
  }
}
