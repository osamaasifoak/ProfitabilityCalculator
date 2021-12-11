import 'package:flutter/material.dart';
import 'package:lichtline/components/app_bars/simple_app_bar_component.dart';
import 'package:lichtline/components/text_component.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/strings/string_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';
import 'package:lichtline/providers/data_provider.dart';
import 'package:lichtline/screens/umweltrechner/umweltrechner.dart';
import 'package:lichtline/ui_utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class KeyFactsScreen extends StatefulWidget {
  @override
  _KeyFactsScreenState createState() => _KeyFactsScreenState();
}

class _KeyFactsScreenState extends State<KeyFactsScreen> {
  DataProvider dataProvider;
  List<Sales> _amortisation = [];
  List<charts.Series> seriesList1;
  List<charts.Series> seriesList2;
  List<charts.Series<Sales, int>> _createRandomData(data1, data2, String unit) {
    return [
      charts.Series<Sales, int>(
        id: 'lichtline',
        domainFn: (Sales sales, _) => int.parse(sales.year),
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
      charts.Series<Sales, int>(
        id: dataProvider.companyName,
        domainFn: (Sales sales, _) => int.parse(sales.year),
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

  @override
  void initState() {
    dataProvider = Provider.of<DataProvider>(context, listen: false);
    _amortisation = dataProvider.calculationKumAmortisation();
    seriesList1 = _createRandomData(
        dataProvider.totalCosting(dataProvider.lichtLine, isNewBulb: true),
        dataProvider.totalCosting(dataProvider.altLosung),
        " t");
    super.initState();
  }

  getInstallationCost() {
    double cost = double.parse(dataProvider.lichtLine[5].value);
    double stuck = double.parse(dataProvider.lichtLine[2].value);
    if (cost != null) {
      return cost * stuck;
    } else {
      return 0;
    }
  }

  kostenerparnis() {
    List<Sales> lichtline = dataProvider.totalCosting(dataProvider.lichtLine);
    List<Sales> oldBulb = dataProvider.totalCosting(dataProvider.altLosung);

    return (oldBulb[oldBulb.length - 1].sales -
            lichtline[lichtline.length - 1].sales)
        .toStringAsFixed(2);
  }

  String co2() {
    List<Sales> lichtline =
        dataProvider.totalCarbonDioxide(dataProvider.lichtLine);
    List<Sales> oldBulb =
        dataProvider.totalCarbonDioxide(dataProvider.altLosung);
    double subtractedValue = oldBulb[0].sales - lichtline[0].sales;
    return (subtractedValue * lichtline.length).toStringAsFixed(2);
  }

  schwefeldioxid() {
    List<Sales> lichtline = dataProvider.totalKw(dataProvider.lichtLine);
    List<Sales> oldBulb = dataProvider.totalKw(dataProvider.altLosung);

    return (((oldBulb[oldBulb.length - 1].sales -
                    lichtline[lichtline.length - 1].sales) *
                0.224) /
            1000)
        .toStringAsFixed(2);
  }

  anschaffungskosten() {
    double initialCost = double.parse(dataProvider.lichtLine[4].value);
    double stuck = double.parse(dataProvider.lichtLine[2].value);

    return stuck * initialCost;
  }

  barChart(_list) {
    return new charts.LineChart(
      _list,
      // vertical: false,
      // barGroupingType: charts.BarGroupingType.grouped,
      behaviors: [
        new charts.SeriesLegend(
          outsideJustification: charts.OutsideJustification.endDrawArea,
          horizontalFirst: false,
          desiredMaxRows: 2,
          cellPadding: new EdgeInsets.only(right: 4.0, bottom: 2.0),
          entryTextStyle:
              charts.TextStyleSpec(fontFamily: 'Georgia', fontSize: 14),
        ),
      ],
      defaultRenderer: charts.LineRendererConfig(
        includeArea: true, stacked: true,
        symbolRenderer: new IconRenderer(Icons.circle),
        //   barRendererDecorator: new charts.BarLabelDecorator(
        //     // labelAnchor: charts.BarLabelAnchor.middle,
        //     labelPosition: charts.BarLabelPosition.auto,
        //     insideLabelStyleSpec: new charts.TextStyleSpec(
        //       fontSize: 11,
        //       color: charts.ColorUtil.fromDartColor(Colors.white),
        //       // lineHeight: 0.14,
        //       fontWeight: '700',
        //     ),
        //     outsideLabelStyleSpec: new charts.TextStyleSpec(
        //       fontSize: 11,
        //       color: charts.ColorUtil.fromDartColor(Color(0xff202020)),
        //       // lineHeight: 0.14,
        //       // fontWeight: '700',
        //     ),
        //   ),
      ),
      domainAxis: new charts.NumericAxisSpec(
        // viewport: new charts.NumericExtents(1, 11)
        tickProviderSpec: new charts.BasicNumericTickProviderSpec(
          zeroBound: false,
          dataIsInWholeNumbers: false,
          desiredTickCount: 12,
        ),
        renderSpec: charts.GridlineRendererSpec(
            tickLengthPx: 0,
            labelOffsetFromAxisPx: 12,
          )   
      ),
      // domainAxis: charts.OrdinalAxisSpec(showAxisLine: true),
    );
  }
  // barChart(_list) {
  //   return new charts.LineChart(
  //     _list,
  //     // vertical: false,
  //     // barGroupingType: charts.BarGroupingType.grouped,

  //     behaviors: [
  //       new charts.SeriesLegend(
  //         outsideJustification: charts.OutsideJustification.endDrawArea,
  //         horizontalFirst: false,
  //         desiredMaxRows: 2,
  //         cellPadding: new EdgeInsets.only(right: 4.0, bottom: 2.0),
  //         entryTextStyle:
  //             charts.TextStyleSpec(fontFamily: 'Georgia', fontSize: 14),
  //       ),
  //       // new charts.ChartTitle('Jahre',
  //       //     behaviorPosition: charts.BehaviorPosition.start,
  //       //     titleStyleSpec: charts.TextStyleSpec(fontSize: 11),
  //       //     titleOutsideJustification:
  //       //         charts.OutsideJustification.startDrawArea),
  //     ],

  //     // selectionModels: [
  //     //   charts.SelectionModelConfig(
  //     //       changedListener: (charts.SelectionModel model) {
  //     //     if (model.hasDatumSelection) {
  //     //       // GroupStackedToolTipMgr.setTitle({
  //     //       //   'title':
  //     //       //       '${model.selectedSeries[0].measureFn(model.selectedDatum[0].index)}',
  //     //       //   'subTitle': '',
  //     //       //   'itemCount': 3,
  //     //       //   'repaintIndex': 1,
  //     //       // });
  //     //     }
  //     //   })
  //     // ],
  //     defaultRenderer: charts.LineRendererConfig(
  //       symbolRenderer: new IconRenderer(Icons.circle),
  //       //   barRendererDecorator: new charts.BarLabelDecorator(
  //       //     // labelAnchor: charts.BarLabelAnchor.middle,
  //       //     labelPosition: charts.BarLabelPosition.auto,
  //       //     insideLabelStyleSpec: new charts.TextStyleSpec(
  //       //       fontSize: 11,
  //       //       color: charts.ColorUtil.fromDartColor(Colors.white),
  //       //       // lineHeight: 0.14,
  //       //       fontWeight: '700',
  //       //     ),
  //       //     outsideLabelStyleSpec: new charts.TextStyleSpec(
  //       //       fontSize: 11,
  //       //       color: charts.ColorUtil.fromDartColor(Color(0xff202020)),
  //       //       // lineHeight: 0.14,
  //       //       // fontWeight: '700',
  //       //     ),
  //       //   ),
  //     ),
  //     // domainAxis:
  //     // new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
  //     // domainAxis: charts.OrdinalAxisSpec(showAxisLine: true),
  //   );
  // }

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
            Flexible(
              child: barChart(seriesList1),
            ),
            Flexible(
              child: Column(
                children: [
                  _summarizeValues(context, "Anschaffungskosten",
                      "${anschaffungskosten()} €"),
                  _summarizeValues(context, "Installationkosten",
                      "${getInstallationCost()} €"),
                  _summarizeValues(context, "Kostnerparnis uber 16 Jahre",
                      "${kostenerparnis().replaceAll(".", ",")} €"),
                  _summarizeValues(context, "Amortisationsdauer", "asdasd"),
                  _summarizeValues(context, "Ø jährliche Rendite", "asdasd"),
                  _summarizeValues(context, "Gesamte CO₂-Einsparung",
                      "${co2().replaceAll(".", ",")} t"),
                  _summarizeValues(context, "Gesamte Schwefeldioxid-Einsparung",
                      "${schwefeldioxid().replaceAll(".", ",")} Kg"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding _summarizeValues(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              color: Colors.blueAccent.withOpacity(0.3),
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Center(
                child: TextComponent(
                  text: title,
                  textStyle: FontStyles.inter(
                      color: ColorConstant.black, fontSize: 12),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              color: Colors.grey.withOpacity(0.3),
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Center(
                child: TextComponent(
                  text: value,
                  textStyle: FontStyles.inter(
                      color: ColorConstant.black, fontSize: 13),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// SingleChildScrollView(
//           child: Column(
//             children: [
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: DataTable(
//                   columns: <DataColumn>[
//                     DataColumn(
//                       numeric: true,
//                       label: Text(
//                         '',
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Kum Amortisation',
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Ersatzkosten',
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Energiekosten',
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'Energieverbrauch kum',
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         'CO2-Verbrauch kum',
//                       ),
//                     ),
//                   ],
//                   rows: <DataRow>[
//                     for (var i = 0; i < _amortisation.length; i++)
//                       DataRow(
//                         cells: <DataCell>[
//                           DataCell(
//                             Text('$i'),
//                           ),
//                           DataCell(
//                             Text('${_amortisation[i].sales} €'),
//                           ),
//                           DataCell(
//                             Text('52,348.03 €'),
//                           ),
//                           DataCell(
//                             Text(''),
//                           ),
//                           DataCell(
//                             Text('138.57 t'),
//                           ),
//                           DataCell(
//                             Text('138.57 t'),
//                           ),
//                         ],
//                       ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
