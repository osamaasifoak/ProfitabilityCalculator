import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lichtline/components/app_logo_component.dart';
import 'package:lichtline/components/buttons/button_component.dart';
import 'package:lichtline/components/input_component.dart';
import 'package:lichtline/components/popup_loader_component.dart';
import 'package:lichtline/components/text_component.dart';
import 'package:lichtline/components/toast_component.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/strings/shared_preference_constants.dart';
import 'package:lichtline/constants/strings/string_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';
import 'package:lichtline/providers/data_provider.dart';
import 'package:lichtline/providers/user_provider.dart';
import 'package:lichtline/services/shared_preferences_service.dart';
import 'package:lichtline/wrappers/user_wrapper.dart';
import 'package:owesome_validator/owesome_validator.dart';
import 'package:provider/provider.dart';

class UserInfoScreen extends StatefulWidget {
  final String fromScreen;

  const UserInfoScreen({Key key, this.fromScreen}) : super(key: key);
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  GlobalKey<FormState> formKey;
  TextEditingController _username;
  TextEditingController _email;
  TextEditingController _phone;
  UserWrapper user;
  final databaseReference = FirebaseDatabase.instance.reference();
  @override
  void initState() {
    user = Provider.of<UserProvider>(context, listen: false).userWrapper;
    _username = new TextEditingController(text: user != null ? user.name : "");
    _email = new TextEditingController(text: user != null ? user.email : "");
    _phone = new TextEditingController(text: user != null ? user.phone : "");
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: _height,
          width: _width,
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 SizedBox(
                  height: 40,
                ),
                AppLogo(),
                SizedBox(
                  height: 40,
                ),
                TextComponent(
                  text: StringConstant.userInformation,
                  textStyle: FontStyles.inter(
                      color: ColorConstant.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16,
                ),
                TextInputComponent(
                  title: StringConstant.username,
                  controller: _username,
                  fillColor: ColorConstant.white,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Icon(
                      Icons.person,
                      color: ColorConstant.black,
                    ),
                  ),
                  filled: true,
                  validator: (value) {
                    if (!OwesomeValidator.name(
                        value, OwesomeValidator.patternNameOnlyChar)) {
                      return "Invalid name";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextInputComponent(
                  title: StringConstant.email,
                  controller: _email,
                  fillColor: ColorConstant.white,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Icon(
                      Icons.email,
                      color: ColorConstant.black,
                    ),
                  ),
                  filled: true,
                  validator: (value) {
                    if (!OwesomeValidator.email(
                        value, OwesomeValidator.patternEmail)) {
                      return "Invalid email";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                InternationalPhoneNumberInput(
                  // hintText: "Ex: xxxx xxxx xxx",
                  onInputChanged: (PhoneNumber number) {
                    print(number.phoneNumber);
                  },
                  onInputValidated: (bool value) {
                    print(value);
                  },
                  selectorConfig: SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  ),
                  ignoreBlank: false,
                  // validator: (value) {
                  //   if (!OwesomeValidator.phone(
                  //       _phone.text, r'^\+(?:[0-9]●?){6,14}[0-9]$')) {
                  //     return "Invalid phone number";
                  //   }
                  //   return null;
                  // },
                  autoValidateMode: AutovalidateMode.disabled,
                  selectorTextStyle: TextStyle(color: Colors.black),
                  // initialValue: number,
                  textFieldController: _phone,
                  formatInput: false,
                  textStyle:
                      FontStyles.inter(color: ColorConstant.greyishBrownTwo),
                  keyboardType: TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  inputBorder: OutlineInputBorder(),
                  onSaved: (PhoneNumber number) {
                    print('On Saved: $number');
                  },
                ),
                // TextInputComponent(
                //   title: "Ex: +xx xxxx xxxx xxx",//StringConstant.phoneNumber,
                //   controller: _phone,
                //   keyboardType: TextInputType.phone,
                //   fillColor: ColorConstant.white,
                //   prefixIcon: Padding(
                //     padding: const EdgeInsets.only(top: 10, bottom: 10),
                //     child: Icon(
                //       Icons.phone,
                //       color: ColorConstant.black,
                //     ),
                //   ),
                //   filled: true,
                //   validator: (value) {
                //     if (!OwesomeValidator.phone(
                //         value, r'^\+(?:[0-9]●?){6,14}[0-9]$')) {
                //       return "Invalid phone number";
                //     }
                //     return null;
                //   },
                // ),
                SizedBox(
                  height: 24,
                ),
                ButtonComponent(
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                      var dataProvider =
                          Provider.of<DataProvider>(context, listen: false);
                      PopupLoader.showLoadingDialog(context);
                      UserProvider _provider =
                          Provider.of<UserProvider>(context, listen: false);
                      UserWrapper _user = UserWrapper(
                          email: _email.text,
                          phone: _phone.text,
                          name: _username.text);
                      try {
                        Map<String, dynamic> data = {};

                        await databaseReference
                            .child("Users")
                            .child(_user.phone)
                            .set(_user.toJson());
                        _provider.userWrapper = _user;
                        if (widget.fromScreen != 'homeMenu') {
                          dataProvider.altLosung
                              .forEach((x) => data[x.fieldName] = x.value);
                          await databaseReference
                              .child("Users_Entries")
                              .child(_user.phone)
                              .push()
                              .set(data);
                        }
                        SharedPreferencesService().addStringInSF(
                            SharedPreferenceConstants.user,
                            json.encode(_user.toJson()));
                        PopupLoader.hideLoadingDialog(context);
                        if (widget.fromScreen != 'homeMenu') {
                          Navigator.pushReplacementNamed(
                              context, widget.fromScreen);
                        } else {
                          Navigator.pop(context);
                          ToastComponent.showToast(
                              "User information updated successfully");
                        }
                      } catch (e) {
                        PopupLoader.hideLoadingDialog(context);
                        ToastComponent.showToast("Something went wrong");
                      }

                      // Provider.of<UserProvider>(context, listen: false)
                      //     .setCompanyName(_companyNameController.text),
                      // Navigator.pushNamed(
                      //     context, RouteConstants.inputScreen),
                    }
                  },
                  buttonText: widget.fromScreen == 'homeMenu'
                      ? "Save"
                      : StringConstant.continueText,
                  color: ColorConstant.black,
                  border: 5,
                  textStyle: FontStyles.inter(
                      color: ColorConstant.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.3,
                      fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
