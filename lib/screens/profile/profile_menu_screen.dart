import 'package:lichtline/components/custom_listTile_component.dart';
import 'package:lichtline/components/review_star_component.dart';
import 'package:lichtline/components/text_component.dart';
import 'package:lichtline/constants/actions/action_constants.dart';
import 'package:lichtline/constants/assets/assets_constants.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/routes/routes_constants.dart';
import 'package:lichtline/constants/strings/string_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';
import 'package:lichtline/ui_utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        color: ColorConstant.whiteBody,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: ColorConstant.black,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: new BoxDecoration(
                            color: ColorConstant.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.network(
                                "https://avatars2.githubusercontent.com/u/49792938?s=460&u=8a709ffa10b8cfd08c4561b37c02d17abb70927f&v=4",
                                height: SizeConfig.screenHeight / 9,
                                width: SizeConfig.screenHeight / 9,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: new BoxDecoration(
                              color: ColorConstant.mango,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: SvgPicture.asset(
                                AssetConstant.pencil_icon,
                                height: 18,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextComponent(
                            text: "Osama Asif",
                            textStyle: FontStyles.inter(
                                color: ColorConstant.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 4.0, bottom: 14.0),
                            child: ReviewStars(
                              starCount: 5,
                              rating: "5.0",
                            ),
                          ),
                          TextComponent(
                            text: "Working since July 19, 2004",
                            textStyle: FontStyles.inter(
                              color: ColorConstant.white,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: SvgPicture.asset(
                          AssetConstant.bell_icon,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            for (var i = 0; i < profileItems.length; i++)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
                child: InkWell(
                  enableFeedback: true,
                  onTap: () {
                    Navigator.pushNamed(
                        context, profileItems[i]["navigate_to_screen"]);
                  },
                  child: CustomListTileComponent(
                    leadingImage: profileItems[i]["leading_icon"],
                    title: profileItems[i]["title"],
                    trailingImage: profileItems[i]["trailing_icon"],
                    trailingIconColor: ColorConstant.greyishBrownThree,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  _onMenuTap(
      {@required String action,
      @required BuildContext context,
      String navigation}) {
    if (action == ActionConstants.navigateForward) {
      Navigator.pushNamed(context, navigation);
    }
  }
}

List profileItems = [
  {
    "leading_icon": AssetConstant.review_icon,
    "title": StringConstant.reviews,
    "trailing_icon": AssetConstant.navigation_forward,
    "onTap": ActionConstants.navigateForward,
    "navigate_to_screen": RouteConstants.reviewScreen,
  },
  {
    "leading_icon": AssetConstant.dispute_icon,
    "title": StringConstant.disputes,
    "trailing_icon": AssetConstant.navigation_forward,
    "onTap": ActionConstants.navigateForward,
    "navigate_to_screen": RouteConstants.profileSettings,
  },
  {
    "leading_icon": AssetConstant.support_icon,
    "title": StringConstant.support,
    "trailing_icon": AssetConstant.navigation_forward,
    "onTap": ActionConstants.navigateForward,
    "navigate_to_screen": RouteConstants.profileSettings,
  },
  {
    "leading_icon": AssetConstant.change_password_icon,
    "title": StringConstant.changePassword,
    "trailing_icon": AssetConstant.navigation_forward,
    "onTap": ActionConstants.navigateForward,
    "navigate_to_screen": RouteConstants.message,
  },
  {
    "leading_icon": AssetConstant.signout_icon,
    "title": StringConstant.signOut,
    "trailing_icon": AssetConstant.navigation_forward,
    "onTap": ActionConstants.navigateForward,
    "navigate_to_screen": RouteConstants.message,
  },
];
