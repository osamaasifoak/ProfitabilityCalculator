import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lichtline/components/app_logo_component.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/routes/routes_constants.dart';
import 'package:lichtline/providers/user_provider.dart';
import 'package:lichtline/services/shared_preferences_service.dart';
import 'package:lichtline/ui_utils/size_config.dart';
import 'package:lichtline/wrappers/user_wrapper.dart';
import 'package:provider/provider.dart';

import 'constants/strings/shared_preference_constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 1),
      () {
        SharedPreferencesService()
            .getStringInSF(SharedPreferenceConstants.user)
            .then(
              (value) => {
                if (value != null)
                  {
                    Provider.of<UserProvider>(context, listen: false)
                        .userWrapper = UserWrapper.fromRawJson(value)
                  },
                Navigator.pushNamed(context, RouteConstants.companyNameScreen)
              },
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        color: ColorConstant.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Flexible(
            //   child: SizedBox(
            //     height: SizeConfig.screenHeight / 4,
            //   ),
            // ),

            AppLogo()

            // TextComponent(
            //   text: StringConstant.lichtLine,
            //   textStyle: FontStyles.inter(
            //       color: ColorConstant.white,
            //       fontSize: 38,
            //       fontWeight: FontWeight.bold),
            //   textAlign: TextAlign.center,
            // ),
          ],
        ),
      ),
    );
  }
}
