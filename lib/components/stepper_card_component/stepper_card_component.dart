import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lichtline/components/text_component.dart';
import 'package:lichtline/constants/assets/assets_constants.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';

class CustomStepperCard extends StatelessWidget {
  final String addressFrom, dateFrom, addressTo, dateTo;
  final Widget childWidgets;
  final bool trailingIcons;
  final bool showOnlyChatTrailingIcon;
  const CustomStepperCard({
    Key key,
    this.childWidgets,
    this.addressFrom,
    this.dateFrom,
    this.addressTo,
    this.dateTo,
    this.trailingIcons = true,
    this.showOnlyChatTrailingIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 15,
          left: 7,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    width: 0.5,
                    color: ColorConstant.greyishBrownThree,
                  ),
                ),
              ),
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  _startAndEndAddress(
                    date: dateFrom,
                    address: addressFrom,
                    trailingIcons: trailingIcons,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _startAndEndAddress(
                      date: dateTo,
                      address: addressTo,
                      trailingIcons: false,
                      leadingIcon: AssetConstant.end_point_icon),
                ],
              ),
            ),
            childWidgets != null ? childWidgets : SizedBox(),
          ],
        ),
      ],
    );
  }

  Row _startAndEndAddress(
      {String date = "",
      String address = "",
      bool trailingIcons = true,
      String leadingIcon = AssetConstant.start_point_icon}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(leadingIcon),
        Flexible(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextComponent(
                  text: date,
                  textStyle: FontStyles.inter(
                      color: ColorConstant.greyishBrownTwo,
                      fontSize: 11,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 3,
                ),
                TextComponent(
                  text: address,
                  textStyle: FontStyles.inter(
                      color: ColorConstant.greyishBrownTwo,
                      fontSize: 11,
                      fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: trailingIcons,
          child: Flexible(
            flex: 4,
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Wrap(
                  children: [
                    SvgPicture.asset(AssetConstant.message_icon),
                    SizedBox(
                      width: 5,
                    ),
                    Visibility(
                      visible: !showOnlyChatTrailingIcon,
                      child: SvgPicture.asset(AssetConstant.track_vehicle_icon),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
