// import 'package:lichtline/components/button_component.dart';
// import 'package:lichtline/components/text_component.dart';
// import 'package:lichtline/constants/assets/assets_constants.dart';
// import 'package:lichtline/constants/colors/colors_constants.dart';
// import 'package:lichtline/constants/routes/routes_constants.dart';
// import 'package:lichtline/constants/strings/string_constants.dart';
// import 'package:lichtline/constants/styles/font_styles_constants.dart';
// import 'package:lichtline/constants/styles/widgets_decoration_constant.dart';
// import 'package:lichtline/ui_utils/size_config.dart';
// import 'package:flutter/material.dart';

// class OnBoardingScreen extends StatefulWidget {
//   @override
//   _OnBoardingScreenState createState() => _OnBoardingScreenState();
// }

// class _OnBoardingScreenState extends State<OnBoardingScreen> {
//   int pageIndex = 0;
//   final pageController = PageController(initialPage: 0);
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//       body: Container(
//         height: SizeConfig.screenHeight,
//         child: Column(
//           children: [
//             Flexible(
//               child: PageView(
//                 controller: pageController,
//                 onPageChanged: (index) {
//                   setState(() {
//                     pageIndex = index;
//                   });
//                 },
//                 children: [
//                   _mainContent(
//                       image: AssetConstant.onboarding_1,
//                       title: StringConstant.onboarding_title_1,
//                       description: StringConstant.onboarding_desc_1),
//                   _mainContent(
//                       image: AssetConstant.onboarding_2,
//                       title: StringConstant.onboarding_title_2,
//                       description: StringConstant.onboarding_desc_2),
//                   _mainContent(
//                       image: AssetConstant.onboarding_3,
//                       title: StringConstant.onboarding_title_3,
//                       description: StringConstant.onboarding_desc_3),
//                 ],
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 for (int i = 0; i < 3; i++)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 4.0, vertical: 20),
//                     child: _indicatorDotsWidget(
//                         color: pageIndex == i
//                             ? ColorConstant.watermelon
//                             : ColorConstant.watermelon.withOpacity(0.3),
//                         width: 8),
//                   ),
//               ],
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 36),
//               child: Container(
//                 decoration: WidgetsDecorationConstant.buttonGradientContainer(),
//                 child: ButtonComponent(
//                   onPressed: () => {
//                     Navigator.pushNamed(context, RouteConstants.login),
//                   },
//                   buttonText: StringConstant.gettingStarted.toUpperCase(),
//                   color: Colors.transparent,
//                   border: 20,
//                   textStyle: FontStyles.inter(
//                       color: ColorConstant.white,
//                       letterSpacing: 1.3,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 12.0),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Column _mainContent(
//       {@required String image,
//       @required String title,
//       @required String description}) {
//     return Column(
//       children: [
//         _centerItemsWidget(image: image),
//         SizedBox(
//           height: 35,
//         ),
//         SizedBox(
//           width: SizeConfig.screenWidth / 1.1,
//           child: Column(
//             children: [
//               TextComponent(
//                 text: title,
//                 textStyle: FontStyles.abrilFatface(
//                     color: ColorConstant.watermelon, fontSize: 29),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 height: 19,
//               ),
//               TextComponent(
//                 text: description,
//                 textStyle:
//                     FontStyles.inter(color: ColorConstant.black, fontSize: 12),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Stack _centerItemsWidget({@required String image}) {
//     return Stack(
//       alignment: Alignment.bottomRight,
//       children: [
//         Transform.translate(
//           offset: Offset(0, -80),
//           child: Center(
//             child: Container(
//               height: SizeConfig.screenHeight / 2,
//               width: SizeConfig.screenWidth / 1.1,
//               decoration: new BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: LinearGradient(
//                   begin: Alignment(1.336418628692627, 0.0688508152961731),
//                   end: Alignment(0.4633900225162506, 1.3446701765060425),
//                   colors: [ColorConstant.strawberry, ColorConstant.pastelRed],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Align(
//           alignment: Alignment.bottomRight,
//           child: Image.asset(image),
//         )
//       ],
//     );
//   }

//   Container _indicatorDotsWidget(
//       {@required Color color, @required double width}) {
//     return Container(
//       height: 8,
//       width: width,
//       decoration: new BoxDecoration(
//           color: color, borderRadius: BorderRadius.circular(10)),
//     );
//   }
// }
