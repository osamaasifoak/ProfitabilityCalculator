import 'package:flutter/material.dart';
import 'package:lichtline/components/app_logo_component.dart';
import 'package:lichtline/components/text_component.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/routes/routes_constants.dart';
import 'package:lichtline/constants/strings/string_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';
import 'package:lichtline/ui_utils/size_config.dart';

class MenuSelectionScreen extends StatefulWidget {
  @override
  _MenuSelectionScreenState createState() => _MenuSelectionScreenState();
}

class _MenuSelectionScreenState extends State<MenuSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    // var dataProvider = Provider.of<DataProvider>(context, listen: false);
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              AppLogo(),
              Expanded(
                flex: 3,
                child: GridView.builder(
                  itemCount: btnList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio:
                          SizeConfig.screenHeight / SizeConfig.screenWidth,
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemBuilder: (context, index) {
                    return Hero(
                      tag: btnList[index]["title"],
                      // transitionOnUserGestures: true,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            btnList[index]["route"],
                          );
                        },
                        child: Container(
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstant.black),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextComponent(
                                text: btnList[index]["title"],
                                textStyle: FontStyles.inter(
                                    color: ColorConstant.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

var btnList = [
  {
    "title": StringConstant.umweltrechner,
    "route": RouteConstants.umweltrechnerScreen,
  },
  {
    "title": StringConstant.wirtschaftlichkeitsrechner,
    "route": RouteConstants.economicCalculator,
  },
  {
    "title": StringConstant.zertifikat,
    "route": RouteConstants.certificateScreen
  },
  {"title": StringConstant.schlusselfaktoren, "route": ""},
];
