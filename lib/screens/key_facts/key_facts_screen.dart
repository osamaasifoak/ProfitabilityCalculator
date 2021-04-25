import 'package:flutter/material.dart';
import 'package:lichtline/components/app_bars/simple_app_bar_component.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/strings/string_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';
import 'package:lichtline/ui_utils/size_config.dart';

class KeyFactsScreen extends StatefulWidget {
  @override
  _KeyFactsScreenState createState() => _KeyFactsScreenState();
}

class _KeyFactsScreenState extends State<KeyFactsScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: SimpleAppBarComponent(
        title: StringConstant.keyFacts,
        titleStyle: FontStyles.inter(
            color: ColorConstant.white,
            fontSize: 16,
            fontWeight: FontWeight.bold),
        color: ColorConstant.black,
      ),
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: <DataColumn>[
                  DataColumn(
                    numeric: true,
                    label: Text(
                      '',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Gesamtkosten',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Ersatzkosten',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Energiekosten',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Energieverbrauch kum',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'CO2-Verbrauch kum',
                    ),
                  ),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Text('0'),
                      ),
                      DataCell(
                        Text('52,348.03 €'),
                      ),
                      DataCell(
                        Text('52,348.03 €'),
                      ),
                      DataCell(
                        Text(''),
                      ),
                      DataCell(
                        Text('138.57 t'),
                      ),
                      DataCell(
                        Text('138.57 t'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
