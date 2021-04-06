import 'package:flutter/material.dart';
import 'package:lichtline/components/app_bars/simple_app_bar_component.dart';
import 'package:lichtline/components/text_component.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/constants/strings/string_constants.dart';
import 'package:lichtline/constants/styles/font_styles_constants.dart';
import 'package:lichtline/screens/pdf/pdf_preview_screen.dart';
import 'package:lichtline/ui_utils/size_config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;

class PdfScreen extends StatefulWidget {
  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  final pdf = pw.Document();
  // @override
  // void initState() {
  //   SizeConfig().init(context);
  //   super.initState();
  // }

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
                _rowTitleAndText("0,00 t", "CO2-Äquivalente"),
                _rowTitleAndText("268,37 kg", "Schwefeldioxid-Äquivalente"),
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
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.SizedBox(
                      width: 150,
                      child: pw.Center(
                        child: pw.Text(
                          "Bayreuth, den 16.10.2020",
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
                        "Maik Weber\n(Geschäftsführer lichtline)",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Transform.translate(
                  offset: Offset(-80, -50),
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green),
                  ),
                ),
                Transform.translate(
                  offset: Offset(-50, 0),
                  child: Column(
                    children: [
                      TextComponent(
                        text: "UMWELT",
                        textStyle: FontStyles.inter(
                            fontSize: 25,
                            color: ColorConstant.greyishBrownTwo,
                            fontWeight: FontWeight.bold),
                      ),
                      TextComponent(
                        text: "ZERTIFIKAT",
                        textStyle: FontStyles.inter(
                            fontSize: 25,
                            color: ColorConstant.greyishBrownTwo,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox()
              ],
            )
          ],
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
}
