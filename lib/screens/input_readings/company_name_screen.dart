import 'package:flutter/material.dart';
import 'package:lichtline/components/app_logo_component.dart';
import 'package:lichtline/components/buttons/button_component.dart';
import 'package:lichtline/components/input_component.dart';
import 'package:lichtline/components/text_component.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/routes/routes_constants.dart';
import 'package:lichtline/constants/strings/string_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';
import 'package:lichtline/providers/data_provider.dart';
import 'package:lichtline/ui_utils/size_config.dart';
import 'package:provider/provider.dart';

class CompanyNameScreen extends StatefulWidget {
  @override
  _CompanyNameScreenState createState() => _CompanyNameScreenState();
}

class _CompanyNameScreenState extends State<CompanyNameScreen> {
  TextEditingController _companyNameController;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _companyNameController = new TextEditingController();
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppLogo(),
                SizedBox(
                  height: 40,
                ),
                TextComponent(
                  text: StringConstant.companyNameScreenText,
                  textStyle: FontStyles.inter(
                      color: ColorConstant.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16,
                ),
                TextInputComponent(
                  title: StringConstant.companyName,
                  controller: _companyNameController,
                  fillColor: ColorConstant.white,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Icon(
                      Icons.house,
                      color: ColorConstant.black,
                    ),
                  ),
                  filled: true,
                  validator: (value) {
                    if (value == "") {
                      return "Company name is required";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                ButtonComponent(
                  onPressed: () => {
                    if (_formKey.currentState.validate())
                      {
                        Provider.of<DataProvider>(context, listen: false)
                            .setCompanyName(_companyNameController.text),
                        Navigator.pushNamed(
                            context, RouteConstants.inputScreen),
                      }
                  },
                  buttonText: StringConstant.continueText,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
