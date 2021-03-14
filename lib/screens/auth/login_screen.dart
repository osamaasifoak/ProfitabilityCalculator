import 'package:flutter/gestures.dart';
import 'package:lichtline/components/app_logo_component.dart';
import 'package:lichtline/components/buttons/button_component.dart';
import 'package:lichtline/components/input_component.dart';
import 'package:lichtline/components/text_component.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/routes/routes_constants.dart';
import 'package:lichtline/constants/strings/string_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';
import 'package:lichtline/ui_utils/size_config.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _usernameTextEditingConrtroller;
  TextEditingController _passwordTextEditingConrtroller;
  TextEditingController _phoneNumberTextEditingConrtroller;
  @override
  void initState() {
    super.initState();
    _usernameTextEditingConrtroller = new TextEditingController();
    _passwordTextEditingConrtroller = new TextEditingController();
    _phoneNumberTextEditingConrtroller = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameTextEditingConrtroller.dispose();
    _passwordTextEditingConrtroller.dispose();
    _phoneNumberTextEditingConrtroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppLogo(),
              // TextComponent(
              //   text: StringConstant.lichtLine,
              //   textStyle: FontStyles.inter(
              //       color: ColorConstant.black,
              //       fontSize: 38,
              //       fontWeight: FontWeight.bold),
              //   textAlign: TextAlign.center,
              // ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 16,
              ),
              TextInputComponent(
                title: StringConstant.username,
                controller: _usernameTextEditingConrtroller,
                fillColor: ColorConstant.white,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Icon(
                    Icons.person,
                    color: ColorConstant.black,
                  ),
                ),
                filled: true,
              ),
              SizedBox(
                height: 10,
              ),
              TextInputComponent(
                title: StringConstant.password,
                controller: _passwordTextEditingConrtroller,
                fillColor: ColorConstant.white,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Icon(
                    Icons.lock,
                    color: ColorConstant.black,
                  ),
                ),
                filled: true,
              ),
              SizedBox(
                height: 24,
              ),
              ButtonComponent(
                onPressed: () => {
                  Navigator.pushNamed(
                      context, RouteConstants.companyNameScreen),
                },
                buttonText: StringConstant.login,
                color: ColorConstant.black,
                border: 5,
                textStyle: FontStyles.inter(
                    color: ColorConstant.white,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.3,
                    fontSize: 16.0),
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextComponent(
                  text: StringConstant.forgotPassword + "?",
                  textStyle: FontStyles.inter(
                      color: ColorConstant.black, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        height: 0,
                        thickness: 0.3,
                        color: ColorConstant.greyishBrownTwo,
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      StringConstant.or.toUpperCase(),
                      style: FontStyles.inter(
                          color: ColorConstant.greyishBrownTwo, fontSize: 14.0),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Divider(
                        height: 0,
                        thickness: 0.3,
                        color: ColorConstant.greyishBrownTwo,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: StringConstant.notAnAccountYet,
                  style: FontStyles.inter(
                      color: ColorConstant.greyishBrownTwo,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                    TextSpan(
                      text: StringConstant.signup,
                      style: FontStyles.inter(
                          color: ColorConstant.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, RouteConstants.signup);
                        },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
