import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:lichtline/components/app_bars/simple_app_bar_component.dart';
import 'package:lichtline/components/text_component.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/strings/string_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';
import 'package:provider/provider.dart';
import '../../providers/data_provider.dart';

class CertificateScreen extends StatefulWidget {
  @override
  CertificateScreenState createState() => CertificateScreenState();
}

class CertificateScreenState extends State<CertificateScreen> {
  List<charts.Series> seriesList;
  DataProvider dataProvider;
  List<charts.Series<Sales, String>> _createRandomData() {
    final lichtLine = dataProvider.totalCarbonDioxide(dataProvider.lichtLine);
    final altLousung = dataProvider.totalCarbonDioxide(dataProvider.altLosung);
    return [
      charts.Series<Sales, String>(
        id: 'lichtline',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: lichtLine,
        fillColorFn: (Sales sales, _) {
          return charts.MaterialPalette.black;
        },
      ),
      charts.Series<Sales, String>(
        id: dataProvider.companyName,
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: altLousung,
        fillColorFn: (Sales sales, _) {
          return charts.MaterialPalette.gray.shadeDefault;
        },
      ),
    ];
  }

  barChart() {
    return new charts.BarChart(
      seriesList,
      vertical: false,
      barGroupingType: charts.BarGroupingType.grouped,
      behaviors: [
        new charts.SeriesLegend(
          outsideJustification: charts.OutsideJustification.endDrawArea,
          horizontalFirst: false,
          desiredMaxRows: 2,
          cellPadding: new EdgeInsets.only(right: 4.0, bottom: 2.0),
          entryTextStyle:
              charts.TextStyleSpec(fontFamily: 'Georgia', fontSize: 14),
        )
      ],
      defaultRenderer: charts.BarRendererConfig(
        symbolRenderer: new IconRenderer(Icons.circle),
      ),
      domainAxis: charts.OrdinalAxisSpec(showAxisLine: true),
    );
  }

  @override
  void initState() {
    super.initState();
    dataProvider = Provider.of<DataProvider>(context, listen: false);
    seriesList = _createRandomData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBarComponent(
        title: "Zertifikat",
        titleStyle: FontStyles.inter(
            color: ColorConstant.white,
            fontSize: 18,
            fontWeight: FontWeight.w600),
        color: ColorConstant.black,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            // TextComponent(
            //   text: StringConstant.co2VerbrouchKum,
            //   textStyle: FontStyles.inter(
            //       color: ColorConstant.black,
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold),
            //   textAlign: TextAlign.center,
            // ),
            Expanded(
              child: barChart(),
            ),
          ],
        ),
      ),
    );
  }
}

class IconRenderer extends charts.CustomSymbolRenderer {
  final IconData iconData;
  IconRenderer(this.iconData);
  @override
  Widget build(BuildContext context, {Size size, Color color, bool enabled}) {
    if (!enabled) {
      color = ColorConstant.brownGrey.withOpacity(0.26);
    }
    //  else {
    //   color = ColorConstant.black;
    // }
    return new SizedBox.fromSize(
        size: size, child: new Icon(iconData, color: color, size: 14.0));
  }
}
