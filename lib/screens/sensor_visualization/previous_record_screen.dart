import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lichtline/components/buttons/button_component.dart';
import 'package:lichtline/components/text_component.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/strings/string_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';
import 'package:lichtline/ui_utils/size_config.dart';
import 'package:lichtline/utils/date_picker_utils.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

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
              padding: const EdgeInsets.only(top: 30, left: 80, right: 80),
              child: ButtonComponent(
                onPressed: () async {
                  showMonthPicker(
                    context: context,
                    firstDate: DateTime(DateTime.now().year, 1),
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
                buttonText: "Select Month",
                color: ColorConstant.black,
                border: 5,
                textStyle: FontStyles.inter(
                    color: ColorConstant.white,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.3,
                    fontSize: 16.0),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 05,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.date_range,
                      size: 50,
                    )),
                Flexible(
                  child: SizedBox(
                    width: 30,
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.timelapse_sharp,
                      size: 50,
                    )),
                Flexible(
                  child: SizedBox(
                    width: 30,
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.sensor_door,
                      size: 50,
                    )),
                Flexible(
                  child: SizedBox(
                    width: 30,
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.merge_type,
                      size: 50,
                    )),
                // Flexible(
                //   child: SizedBox(
                //     width: 30,
                //   ),
                // ),
                // Align(
                //     alignment: Alignment.centerRight,
                //     child: Icon(
                //       Icons.score,
                //       size: 50,
                //     )),
              ],

              // children: [
              //   Icon(Icons.calendar_today),
              //   Icon(Icons.sensor_door),
              //   Icon(Icons.merge_type),
              // ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text('Date'),
                Flexible(
                  child: SizedBox(
                    width: 30,
                  ),
                ),
                Text('Minutes'),
                Flexible(
                  child: SizedBox(
                    width: 40,
                  ),
                ),
                Text('Pace'),
                Flexible(
                  child: SizedBox(
                    width: 45,
                  ),
                ),
                Text('Score'),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: databaseReference
                    .child("HnHUcA6MT7WxdAz3pFCQWqkwOWj1")
                    .child(_selectedDateTime.year.toString())
                    .child(_selectedDateTime.month.toString())
                    .once(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && !snapshot.hasError) {
                    Map<dynamic, dynamic> _data = snapshot.data.value;
                    print(_data.values);
                    return ListView.builder(
                        itemCount: _data.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              // TextComponent(
                              //   text: _data[index],
                              // )
                            ],
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
