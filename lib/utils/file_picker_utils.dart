// import 'dart:io';

// import 'package:file_picker/file_picker.dart';

// class FilePickerUtils {
//   FilePickerResult result;

//   Future<List<File>> pickFile() async {
//     List<File> files = [];
//     result = await FilePicker.platform.pickFiles(
//         allowMultiple: true, type: FileType.image, allowCompression: true
//         // allowedExtensions: ['jpg'],
//         );
//     if (result != null) {
//       files = result.paths.map((path) => File(path)).toList();
//     }
//     return files;
//   }
// }
