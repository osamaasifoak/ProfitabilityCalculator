import 'package:firebase_database/firebase_database.dart';
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
import 'package:lichtline/utils/date_formatter_utils.dart';
import 'package:lichtline/utils/date_picker_utils.dart';

class SensorVisualizationScreen extends StatefulWidget {
  @override
  _SensorVisualizationScreenState createState() =>
      _SensorVisualizationScreenState();
}

class _SensorVisualizationScreenState extends State<SensorVisualizationScreen>
    with SingleTickerProviderStateMixin {
  DateTime _selectedDateTime;
  TextEditingController _dateTimeTextEditingConrtroller;
  TextEditingController _sensorVlauesTextEditingConrtroller;
  TextEditingController _phoneNumberTextEditingConrtroller;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final databaseReference = FirebaseDatabase.instance.reference();
  @override
  void initState() {
    super.initState();
    _dateTimeTextEditingConrtroller = new TextEditingController();
    _sensorVlauesTextEditingConrtroller = new TextEditingController();
    _phoneNumberTextEditingConrtroller = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _dateTimeTextEditingConrtroller.dispose();
    _sensorVlauesTextEditingConrtroller.dispose();
    _phoneNumberTextEditingConrtroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth / 4,
                    child: AppLogo(),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextComponent(
                    text: StringConstant.sensorVisualization,
                    textStyle: FontStyles.inter(
                        color: ColorConstant.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () async {
                      await DatePickerUitls.selectDate(
                        context,
                        (date) async {
                          if (date != null) {
                            setState(() {
                              _dateTimeTextEditingConrtroller.text =
                                  date.toString();
                            });
                            await DatePickerUitls.selectTime(
                              context,
                              (time) {
                                if (time != null) {
                                  DateTime newDateTime = date.add(Duration(
                                      hours: time.hour, minutes: time.minute));
                                  _selectedDateTime = newDateTime;
                                  _dateTimeTextEditingConrtroller.text =
                                      DateFormatter.getDateAndTime(
                                          newDateTime.toString());
                                  print(newDateTime);
                                }
                              },
                            );
                          }
                        },
                      );
                    },
                    child: TextInputComponent(
                      title: StringConstant.dateAndTime,
                      controller: _dateTimeTextEditingConrtroller,
                      fillColor: ColorConstant.white,
                      enabled: false,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Icon(
                          Icons.calendar_today,
                          color: ColorConstant.black,
                        ),
                      ),
                      filled: true,
                      validator: (value) {
                        if (value == "") {
                          return "Select ${StringConstant.dateAndTime}";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextInputComponent(
                    title: StringConstant.sensorValues,
                    controller: _sensorVlauesTextEditingConrtroller,
                    fillColor: ColorConstant.white,
                    keyboardType: TextInputType.number,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Icon(
                        Icons.sensor_door,
                        color: ColorConstant.black,
                      ),
                    ),
                    validator: (value) {
                      if (value == "") {
                        return "Select ${StringConstant.sensorValues}";
                      }
                      return null;
                    },
                    filled: true,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  ButtonComponent(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        databaseReference
                            .child("HnHUcA6MT7WxdAz3pFCQWqkwOWj1")
                            .child(_selectedDateTime.year.toString())
                            .child(_selectedDateTime.month.toString())
                            .child(_selectedDateTime.day.toString())
                            .set({
                          "date_time": _selectedDateTime.toString(),
                          "sensor_values":
                              _sensorVlauesTextEditingConrtroller.text,
                          "sensor_type": "test"
                        });

                        // Navigator.pushNamed(
                        //     context, RouteConstants.companyNameScreen),
                      }
                    },
                    buttonText: StringConstant.submit,
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
      ),
    );
  }
}
