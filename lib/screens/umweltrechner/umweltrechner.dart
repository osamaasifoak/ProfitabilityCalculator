import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:lichtline/components/app_bars/simple_app_bar_component.dart';
import 'package:lichtline/components/text_component.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/strings/string_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';
import 'package:provider/provider.dart';
import '../../components/tab_bar_component.dart';
import '../../providers/data_provider.dart';

class UmweltrechnerScreen extends StatefulWidget {
  @override
  UmweltrechnerScreenState createState() => UmweltrechnerScreenState();
}

class UmweltrechnerScreenState extends State<UmweltrechnerScreen> {
  List<charts.Series> seriesList1;
  List<charts.Series> seriesList2;
  DataProvider dataProvider;
  List<charts.Series<Sales, String>> _createRandomData(
      data1, data2, String unit) {
    return [
      charts.Series<Sales, String>(
        id: 'lichtline',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        labelAccessorFn: (Sales sales, _) =>
            sales.sales.toStringAsFixed(2) + unit,
        // insideLabelStyleAccessorFn: ,

        data: data1,
        fillColorFn: (Sales sales, _) {
          return charts.MaterialPalette.black;
        },
        colorFn: (Sales sales, _) {
          return charts.MaterialPalette.black;
        },
      ),
      charts.Series<Sales, String>(
        id: dataProvider.companyName,
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        labelAccessorFn: (Sales sales, _) =>
            sales.sales.toStringAsFixed(2) + unit,
        data: data2,
        fillColorFn: (Sales sales, _) {
          return charts.MaterialPalette.gray.shadeDefault;
        },
        colorFn: (Sales sales, _) {
          return charts.MaterialPalette.gray.shadeDefault;
        },
      ),
    ];
  }

  barChart(_list) {
    return new charts.BarChart(
      _list,
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
        ),
        new charts.ChartTitle('Jahre',
            behaviorPosition: charts.BehaviorPosition.start,
            titleStyleSpec: charts.TextStyleSpec(fontSize: 11),
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
      ],
      selectionModels: [
        charts.SelectionModelConfig(
            changedListener: (charts.SelectionModel model) {
          if (model.hasDatumSelection) {
            GroupStackedToolTipMgr.setTitle({
              'title':
                  '${model.selectedSeries[0].measureFn(model.selectedDatum[0].index)}',
              'subTitle': '',
              'itemCount': 3,
              'repaintIndex': 1,
            });
          }
        })
      ],
      defaultRenderer: charts.BarRendererConfig(
        symbolRenderer: new IconRenderer(Icons.circle),
        barRendererDecorator: new charts.BarLabelDecorator(
          // labelAnchor: charts.BarLabelAnchor.middle,
          labelPosition: charts.BarLabelPosition.auto,
          insideLabelStyleSpec: new charts.TextStyleSpec(
            fontSize: 11,
            color: charts.ColorUtil.fromDartColor(Colors.white),
            // lineHeight: 0.14,
            fontWeight: '700',
          ),
          outsideLabelStyleSpec: new charts.TextStyleSpec(
            fontSize: 11,
            color: charts.ColorUtil.fromDartColor(Color(0xff202020)),
            // lineHeight: 0.14,
            // fontWeight: '700',
          ),
        ),
      ),
      // domainAxis:
      // new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
      domainAxis: charts.OrdinalAxisSpec(showAxisLine: true),
    );
  }

  @override
  void initState() {
    super.initState();
    dataProvider = Provider.of<DataProvider>(context, listen: false);
    seriesList1 = _createRandomData(
        dataProvider.totalCarbonDioxide(dataProvider.lichtLine),
        dataProvider.totalCarbonDioxide(dataProvider.altLosung),
        " t");
    seriesList2 = _createRandomData(
        dataProvider.totalKw(dataProvider.lichtLine),
        dataProvider.totalKw(dataProvider.altLosung),
        " kWh");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBarComponent(
        title: StringConstant.umweltrechner,
        titleStyle: FontStyles.inter(
            color: ColorConstant.white,
            fontSize: 18,
            fontWeight: FontWeight.w600),
        color: ColorConstant.black,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20.0),
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TabBarViewComponent(
                  childrenTabs: [
                    barChart(seriesList1),
                    barChart(seriesList2),
                  ],
                  tabsName: [
                    StringConstant.co2VerbrouchKum,
                    StringConstant.energieVerbrouchKum,
                  ],
                  horizontalPadding: 15,
                ),
              ),
              // TextComponent(
              //   text: StringConstant.co2VerbrouchKum,
              //   textStyle: FontStyles.inter(
              //       color: ColorConstant.black,
              //       fontSize: 20,
              //       fontWeight: FontWeight.bold),
              //   textAlign: TextAlign.center,
              // ),
              // TextComponent(
              //   text: StringConstant.energieVerbrouchKum,
              //   textStyle: FontStyles.inter(
              //       color: ColorConstant.black,
              //       fontSize: 20,
              //       fontWeight: FontWeight.bold),
              //   textAlign: TextAlign.center,
              // ),
              // Expanded(
              //   child: barChart(seriesList2),
              // ),
            ],
          ),
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

String _title;
String _subTitle;
int _itemCounter;
int _repaintIndex;
bool _flag;

class GroupStackedToolTipMgr {
  static String get title => _title;
  static String get subTitle => _subTitle;
  static int get itemCounter => _itemCounter;
  static int get repaintIndex => _repaintIndex;
  static bool get flag => _flag;
  static set flag(_val) {
    _flag = _val;
  }

  static setTitle(Map<String, dynamic> data) {
    _flag = false;
    if (data['title'] != null && data['title'].length > 0) {
      _title = data['title'];
    }

    if (data['subTitle'] != null && data['subTitle'].length > 0) {
      _subTitle = data['subTitle'];
    }

    if (data['itemCounter'] != null && data['itemCounter'] > 0) {
      _itemCounter = data['itemCounter'];
    }

    if (data['repaintIndex'] != null) {
      _repaintIndex = data['repaintIndex'];
    }
  }
}
