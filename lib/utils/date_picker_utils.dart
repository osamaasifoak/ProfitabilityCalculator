import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';

class DatePickerUitls {
  static DateFormat dateFormat = DateFormat("dd-MM-yyyy hh:mm");
  static Future<Null> selectDate(
      BuildContext context, Function(DateTime) onValue) async {
    showDatePicker(
      context: context,
      firstDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(DateTime.now().year, 12, 31),
      initialDate: DateTime.now(),
      locale: Locale("en"),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: ColorConstant.black,
            accentColor: ColorConstant.black,
            colorScheme: ColorScheme.light(primary: ColorConstant.black),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    ).then(onValue);
  }

  static Future<Null> selectTime(
      BuildContext context, Function(TimeOfDay) onValue) async {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: ColorConstant.black,
            accentColor: ColorConstant.black,
            colorScheme: ColorScheme.light(primary: ColorConstant.black),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    ).then(onValue);
  }

  static dialogDatePicker(BuildContext context, Function(DateTime) onValue) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {},
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Transform.scale(
          scale: animation.value,
          child: Opacity(
              opacity: animation.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                content: SizedBox(
                  height: 300,
                  width: 500,
                  child: CalendarDatePicker(
                      firstDate: DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day),
                      lastDate: DateTime(DateTime.now().year, 12, 31),
                      initialDate: DateTime.now(),
                      onDateChanged: onValue),
                ),
              )),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
    );
  }
}
