import 'package:flutter/material.dart';
import 'package:lichtline/components/app_bars/simple_app_bar_component.dart';
import 'package:lichtline/components/text_component.dart';
import 'package:lichtline/constants/assets/assets_constants.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/strings/string_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';
import 'package:lichtline/providers/data_provider.dart';
import 'package:lichtline/screens/pdf/pdf_preview_screen.dart';
import 'package:lichtline/utils/date_formatter_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';

class PdfScreen extends StatefulWidget {
  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  final pdf = pw.Document();
  DataProvider dataProvider;

  @override
  void initState() {
    dataProvider = Provider.of<DataProvider>(context, listen: false);
    super.initState();
  }

  writeOnPdf(BuildContext _context) {
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.only(left: 32, right: 32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Container(
            height: MediaQuery.of(_context).size.height,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Container(
                  height: 200,
                  width: 200,
                  decoration: new pw.BoxDecoration(
                    shape: pw.BoxShape.circle,
                    color: PdfColors.green,
                    // boxShadow: [
                    //   pw.BoxShadow(color: PdfColors.black., blurRadius: 2)
                    // ],
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        "UMWELT",
                        style: pw.TextStyle(
                            fontSize: 25,
                            color: PdfColors.white,
                            fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        "ZERTIFIKAT",
                        style: pw.TextStyle(
                            fontSize: 25,
                            color: PdfColors.white,
                            fontWeight: pw.FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(
                  height: 20,
                ),
                pw.Text(
                  "Die Firma lichtline bestätigt der",
                  style: pw.TextStyle(
                      fontSize: 20,
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(
                  height: 20,
                ),
                pw.Text(
                  "Rehau AG + Co",
                  style: pw.TextStyle(
                      fontSize: 45,
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(
                  height: 20,
                ),
                pw.Text(
                  "durch die Umrüstung auf lichtline-Beleuchtung überden gesamten Nutzungszeitraum folgende Einsparungen:",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      fontSize: 18,
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(
                  height: 20,
                ),
                _rowTitleAndText(
                    "${co2().replaceAll(".", ",")} t", "CO2-Äquivalente"),
                _rowTitleAndText("${schwefeldioxid().replaceAll(".", ",")} kg",
                    "Schwefeldioxid-Äquivalente"),
                _rowTitleAndText("488,82 kg", "Stickstoffdioxid-Äquivalente"),
                _rowTitleAndText("220,45 kg", "Kohlenmonoxid-Äquivalente"),
                pw.SizedBox(
                  height: 20,
                ),
                pw.Text(
                  "Die dabei jährlich eingesparten Treibhausemissionen entsprechen der Menge, die",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      fontSize: 18,
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(
                  height: 20,
                ),
                pw.Text(
                  "5.612 Bäume",
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                      fontSize: 18,
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(
                  height: 20,
                ),
                pw.Text(
                  "pro Jahr binden können.",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      fontSize: 18,
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(
                  height: 40,
                ),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.SizedBox(
                      width: 150,
                      child: pw.Center(
                        child: pw.Text(
                          "Bayreuth, den ${DateFormatter.getDateDDMMYY(DateTime.now().toString())}",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 18,
                              color: PdfColors.black,
                              fontWeight: pw.FontWeight.normal),
                        ),
                      ),
                    ),
                    pw.SizedBox(width: 10, height: 30),
                    pw.Container(
                      width: 120,
                      decoration: new pw.BoxDecoration(
                        border: pw.Border(
                          top: pw.BorderSide(width: 1, color: PdfColors.black),
                        ),
                      ),
                      child: pw.Text(
                        "Matthias\n(Geschäftsführer lichtline)",
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                            fontSize: 18,
                            color: PdfColors.black,
                            fontWeight: pw.FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ];
      },
    ));
  }

  pw.Row _rowTitleAndText(String value, String text) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.SizedBox(
          width: 100,
          child: pw.Center(
            child: pw.Text(
              value,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                  fontSize: 18,
                  color: PdfColors.black,
                  fontWeight: pw.FontWeight.normal),
            ),
          ),
        ),
        pw.SizedBox(width: 10, height: 30),
        // pw.SizedBox(
        //   width: 160,
        //   child:
        pw.Text(
          text,
          textAlign: pw.TextAlign.left,
          style: pw.TextStyle(
              fontSize: 18,
              color: PdfColors.black,
              fontWeight: pw.FontWeight.bold),
        ),
        // )
      ],
    );
  }

  Future savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    File file = File("$documentPath/example.pdf");

    file.writeAsBytesSync(await pdf.save());
  }
//   Future<void> saveFile() async {
//     final pdf = pw.Document();
//     List<Directory> appDocDirectory = await getExternalStorageDirectories();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) => pw.Center(
//           child: pw.Text('Hello World!'),
//         ),
//       ),
//     );

// //     new Directory(appDocDirectory.path + '/' + 'dir').create(recursive: true)
// // // The created directory is returned as a Future.
// //         .then((Directory directory) async {
// //       print('Path of New Dir: ' + directory.path);
// //       final file = File(directory.path + 'example.pdf');
// //       await file.writeAsBytes(await pdf.save());
// //     });
//   }
  String co2() {
    List<Sales> lichtline =
        dataProvider.totalCarbonDioxide(dataProvider.lichtLine);
    List<Sales> oldBulb =
        dataProvider.totalCarbonDioxide(dataProvider.altLosung);

    return ((oldBulb[0].sales - lichtline[0].sales) * lichtline.length)
        .toStringAsFixed(2);
  }

  String schwefeldioxid() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBarComponent(
        title: StringConstant.zertifikat,
        titleStyle: FontStyles.inter(
            color: ColorConstant.white,
            fontSize: 18,
            fontWeight: FontWeight.w600),
        color: ColorConstant.black,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: ColorConstant.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              TextComponent(
                text: "UMWELT",
                textStyle: FontStyles.inter(
                    fontSize: 30,
                    color: ColorConstant.black,
                    fontWeight: FontWeight.bold),
              ),
              TextComponent(
                text: "ZERTIFIKAT",
                textStyle: FontStyles.inter(
                    fontSize: 30,
                    color: ColorConstant.black,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Image.asset(AssetConstant.leafLicht),
              ),
              TextComponent(
                text: "Die Firma lichtline bestätigt der",
                textStyle: FontStyles.inter(
                    fontSize: 18,
                    color: ColorConstant.black,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              TextComponent(
                text: "Rehau AG + Co",
                textStyle: FontStyles.inter(
                    fontSize: 40,
                    color: ColorConstant.black,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              TextComponent(
                text:
                    "durch die Umrüstung auf lichtline-Beleuchtung über den gesamten Nutzungszeitraum folgende Einsparungen:",
                textStyle: FontStyles.inter(
                    fontSize: 18,
                    color: ColorConstant.black,
                    height: 1.2,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              titleAndTrailingText(
                  "${co2().replaceAll(".", ",")} t", "CO2-Äquivalente"),
              titleAndTrailingText(
                  "${schwefeldioxid().replaceAll(".", ",")}  kg",
                  "Schwefeldioxid-Äquivalente"),
              titleAndTrailingText("488,82 kg", "Stickstoffdioxid-Äquivalente"),
              titleAndTrailingText("220,45 kg", "Kohlenmonoxid-Äquivalente"),
              SizedBox(
                height: 15,
              ),
              TextComponent(
                text:
                    "Die dabei jährlich eingesparten Treibhausemissionen entsprechen der Menge, die",
                textStyle: FontStyles.inter(
                    fontSize: 18,
                    color: ColorConstant.black,
                    height: 1.2,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              TextComponent(
                text: "5.612 Bäume",
                textStyle: FontStyles.inter(
                    fontSize: 18,
                    color: ColorConstant.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 15,
              ),
              TextComponent(
                text: "pro Jahr binden können.",
                textStyle: FontStyles.inter(
                    fontSize: 18,
                    color: ColorConstant.black,
                    height: 1.2,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150,
                      child: TextComponent(
                        text:
                            "Bayreuth, den ${DateFormatter.getDateDDMMYY(DateTime.now().toString())}",
                        textStyle: FontStyles.inter(
                            fontSize: 14,
                            color: ColorConstant.black,
                            height: 1.2,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(width: 10, height: 30),
                    Container(
                      width: 120,
                      decoration: new BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1, color: ColorConstant.black),
                        ),
                      ),
                      child: Text(
                        "Matthias\n(Geschäftsführer lichtline)",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18,
                            color: ColorConstant.black,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Image.asset(AssetConstant.tree),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Image.asset(AssetConstant.lichtline),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          writeOnPdf(context);
          await savePdf();

          Directory documentDirectory =
              await getApplicationDocumentsDirectory();

          String documentPath = documentDirectory.path;

          String fullPath = "$documentPath/example.pdf";

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PdfPreviewScreen(
                        path: fullPath,
                      )));
        },
        child: Icon(Icons.save),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Padding titleAndTrailingText(String title, String trailingText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextComponent(
            text: title,
            textStyle: FontStyles.inter(
                fontSize: 14,
                color: ColorConstant.black,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          TextComponent(
            text: trailingText,
            textStyle: FontStyles.inter(
                fontSize: 14,
                color: ColorConstant.black,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
