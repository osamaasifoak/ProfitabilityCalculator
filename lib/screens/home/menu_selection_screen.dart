import 'package:flutter/material.dart';
import 'package:lichtline/components/app_logo_component.dart';
import 'package:lichtline/components/text_component.dart';
import 'package:lichtline/components/toast_component.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/routes/routes_constants.dart';
import 'package:lichtline/constants/strings/string_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';
import 'package:lichtline/providers/user_provider.dart';
import 'package:lichtline/screens/home/user_info_screen.dart';
import 'package:lichtline/ui_utils/size_config.dart';
import 'package:lichtline/wrappers/user_wrapper.dart';
import 'package:provider/provider.dart';

class MenuSelectionScreen extends StatefulWidget {
  @override
  _MenuSelectionScreenState createState() => _MenuSelectionScreenState();
}

class _MenuSelectionScreenState extends State<MenuSelectionScreen> {
  UserWrapper user;
  @override
  void initState() {
    user = Provider.of<UserProvider>(context, listen: false).userWrapper;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var dataProvider = Provider.of<DataProvider>(context, listen: false);
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        actions: [
          Visibility(
            visible: user != null,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfoScreen(
                      fromScreen: "homeMenu",
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.person,
                  color: ColorConstant.white,
                ),
              ),
            ),
          )
        ],
        backgroundColor: ColorConstant.black,
      ),
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
              SizedBox(height: 20),
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
                          if (StringConstant.wirtschaftlichkeitsrechner ==
                              btnList[index]["title"]) {
                            ToastComponent.showToast("In progress");
                          } else if (StringConstant.keyFacts ==
                              btnList[index]["title"]) {
                            var user = Provider.of<UserProvider>(context,
                                    listen: false)
                                .userWrapper;
                            if (user != null) {
                              Navigator.pushNamed(
                                context,
                                btnList[index]["route"],
                              );
                            } else {
                              _showUserConfirmationDialog(
                                  btnList[index]["route"]);
                            }
                          } else {
                            Navigator.pushNamed(
                              context,
                              btnList[index]["route"],
                            );
                          }
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

  _showUserConfirmationDialog(String routeArgument) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Hello',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'We need your some information to send you a final results.',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RouteConstants.userInfoScreen,
                    arguments: routeArgument);
              },
            )
          ],
        );
      },
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
  {"title": StringConstant.zertifikat, "route": RouteConstants.pdfScreen},
  {"title": StringConstant.keyFacts, "route": RouteConstants.keyFacts},
  // {
  //   "title": StringConstant.schlusselfaktoren,
  //   "route": RouteConstants.certificateScreen
  // },
];
