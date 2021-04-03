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

  writeOnPdf() {
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          // pw.Column(
          //   children: [
          //     C
          //   ],
          // ),
          // pw.Column(
          //   crossAxisAlignment: pw.CrossAxisAlignment.center,
          //   children: [
          //     pw.Row(
          //       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          //       children: [
          //         pw.Transform.translate(
          //           offset: PdfPoints(-80, -50),
          //           child: pw.Container(
          //             height: 200,
          //             width: 200,
          //             decoration: new pw.BoxDecoration(
          //                 shape: pw.BoxShape.circle, color: PdfColors.green),
          //           ),
          //         ),
          //         pw.Transform.translate(
          //           offset: Offset(-50, 0),
          //           child: pw.Column(
          //             children: [
          //               pw.Text(
          //                 "UMWELT",
          //                 style: pw.TextStyle(
          //                     fontSize: 25,
          //                     color: PdfColors.black,
          //                     fontWeight: ),
          //               ),
          //               TextComponent(
          //                 text: "ZERTIFIKAT",
          //                 textStyle: FontStyles.inter(
          //                     fontSize: 25,
          //                     color: ColorConstant.greyishBrownTwo,
          //                     fontWeight: FontWeight.bold),
          //               ),
          //             ],
          //           ),
          //         ),
          //         SizedBox()
          //       ],
          //     )
          //   ],
          // ),
          // pw.Header(level: 0, child: pw.Text("UMWELT\nZERTIFIKAT")),
          // pw.Paragraph(
          //     text:
          //         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
          // pw.Paragraph(
          //     text:
          //         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
          // pw.Header(level: 1, child: pw.Text("Second Heading")),
          // pw.Paragraph(
          //     text:
          //         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
          // pw.Paragraph(
          //     text:
          //         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
          // pw.Paragraph(
          //     text:
          //         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
        ];
      },
    ));
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
          writeOnPdf();
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
