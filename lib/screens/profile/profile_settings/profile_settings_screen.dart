// import 'package:lichtline/components/app_bars/simple_app_bar_component.dart';
// import 'package:lichtline/components/custom_listTile_component.dart';
// import 'package:lichtline/constants/actions/action_constants.dart';
// import 'package:lichtline/constants/assets/assets_constants.dart';
// import 'package:lichtline/constants/colors/colors_constants.dart';
// import 'package:lichtline/constants/routes/routes_constants.dart';
// import 'package:lichtline/constants/strings/string_constants.dart';
// import 'package:lichtline/constants/styles/font_styles_constants.dart';
// import 'package:lichtline/constants/widgets/app_bar_widgets_constants.dart';
// import 'package:lichtline/ui_utils/size_config.dart';
// import 'package:flutter/material.dart';

// class ProfileSettingsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//       appBar: AppBarWidgetConstants.appBarWithbackButton(
//           title: StringConstant.profileSettings),
//       body: Container(
//         height: SizeConfig.screenHeight,
//         color: ColorConstant.bodyColor,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               for (var i = 0; i < profileItems.length; i++)
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
//                   child: InkWell(
//                     onTap: () {
//                       _onTap(
//                           context: context,
//                           action: profileItems[i]["onTap"],
//                           navigation: profileItems[i]["navigate_to_screen"]);
//                     },
//                     child: CustomListTileComponent(
//                       leadingImage: profileItems[i]["leading_icon"],
//                       title: profileItems[i]["title"],
//                       trailingImage: profileItems[i]["trailing_icon"],
//                     ),
//                   ),
//                 )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _onTap(
//       {@required String action,
//       @required BuildContext context,
//       String navigation}) {
//     if (action == ActionConstants.navigateForward) {
//       Navigator.pushNamed(context, navigation);
//     }
//   }
// }

// List profileItems = [
//   {
//     "leading_icon": AssetConstant.person_icon,
//     "title": StringConstant.personalInformation,
//     "trailing_icon": AssetConstant.ios_forward_icon,
//     "onTap": ActionConstants.navigateForward,
//     "navigate_to_screen": ActionConstants.navigateForward,
//   },
//   {
//     "leading_icon": AssetConstant.docs_icon,
//     "title": StringConstant.myDocuments,
//     "trailing_icon": AssetConstant.ios_forward_icon,
//     "onTap": ActionConstants.navigateForward,
//     "navigate_to_screen": RouteConstants.myDocs,
//   },
//   {
//     "leading_icon": AssetConstant.language_icon,
//     "title": StringConstant.languagePreference,
//     "trailing_icon": AssetConstant.ios_forward_icon,
//     "onTap": ActionConstants.navigateForward,
//     "navigate_to_screen": ActionConstants.navigateForward,
//   },
// ];
