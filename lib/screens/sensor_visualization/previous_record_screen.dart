import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:lichtline/components/buttons/button_component.dart';
import 'package:lichtline/components/text_component.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/strings/string_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';
import 'package:lichtline/ui_utils/size_config.dart';
import 'package:lichtline/utils/date_formatter_utils.dart';
import 'package:lichtline/utils/date_picker_utils.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:intl/intl.dart';

class PreviousRecordScreen extends StatefulWidget {
  @override
  _PreviousRecordScreenState createState() => _PreviousRecordScreenState();
}

class _PreviousRecordScreenState extends State<PreviousRecordScreen> {
  DateTime _selectedDateTime;
  final databaseReference = FirebaseDatabase.instance.reference();
  @override
  void initState() {
    _selectedDateTime = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 60, left: 60, right: 60, bottom: 20),
              child: ButtonComponent(
                onPressed: () async {
                  showMonthPicker(
                    context: context,
                    firstDate: DateTime(DateTime.now().year - 1, 1),
                    lastDate: DateTime(DateTime.now().year, 12),
                    initialDate: _selectedDateTime,
                  ).then((date) {
                    if (date != null) {
                      setState(() {
                        _selectedDateTime = date;
                        // print(_selectedDateTime);
                      });
                    }
                  });
                },
                buttonText: DateFormat('yyyy, MMM').format(_selectedDateTime),
                // "year ${_selectedDateTime.year}, ${_selectedDateTime.month}",
                color: ColorConstant.black,
                border: 5,
                textStyle: FontStyles.inter(
                    color: ColorConstant.white,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.3,
                    fontSize: 16.0),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FirebaseAnimatedList(
                  key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(bottom: 20),
                  query: databaseReference
                      .child("HnHUcA6MT7WxdAz3pFCQWqkwOWj1")
                      .child(_selectedDateTime.year.toString())
                      .child(_selectedDateTime.month.toString()),
                  sort: (DataSnapshot a, DataSnapshot b) =>
                      b.key.compareTo(a.key),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    if (snapshot.value != null) {
                      Map<dynamic, dynamic> _data = snapshot.value;
                      print(_data);
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Visibility(
                                  visible: index == 0,
                                  child: _iconWithTextColumn(
                                      Icons.calendar_today,
                                      StringConstant.dateAndTime),
                                ),
                                TextComponent(
                                  text: DateFormatter.getDateAndTime(
                                      _data["date_time"]),
                                ),
                              ],
                            ),
                            Flexible(
                              child: SizedBox(
                                width: SizeConfig.screenWidth / 3,
                                child: Column(
                                  children: [
                                    Visibility(
                                      visible: index == 0,
                                      child: _iconWithTextColumn(
                                          Icons.sensor_door, "Sensor values"),
                                    ),
                                    TextComponent(
                                      text: _data["sensor_values"],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              child: SizedBox(
                                width: SizeConfig.screenWidth / 3,
                                child: Column(
                                  children: [
                                    Visibility(
                                      visible: index == 0,
                                      child: _iconWithTextColumn(
                                          Icons.merge_type, "Sensor type"),
                                    ),
                                    TextComponent(
                                      text: _data["sensor_type"],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _iconWithTextColumn(IconData icon, String text) {
    return Column(
      children: [
        Icon(
          icon,
          size: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextComponent(
            text: text,
            textStyle: FontStyles.inter(
                color: ColorConstant.greyishBrownTwo,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
        ),
      ],
    );
  }
}
