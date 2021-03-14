// import 'package:fdottedline/fdottedline.dart';
// import 'package:flutter/material.dart';
// import 'package:lichtline/constants/colors/colors_constants.dart';

// class AddImagePlaceHolderComponent extends StatelessWidget {
//   final int placeHolderLength;
//   final void Function() onTap;
//   const AddImagePlaceHolderComponent(
//       {Key key, this.placeHolderLength = 1, this.onTap})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       children: [
//         for (var i = 0; i < placeHolderLength; i++)
//           Padding(
//             padding: EdgeInsets.only(
//                 right: i != placeHolderLength - 1 ? 5.0 : 0.0, bottom: 10),
//             child: InkWell(
//               enableFeedback: true,
//               onTap: onTap,
//               child: FDottedLine(
//                 color: ColorConstant.brownGrey,
//                 strokeWidth: 2.0,
//                 dottedLength: 10.0,
//                 space: 2.0,
//                 corner: FDottedLineCorner.all(7),
//                 child: Container(
//                   padding: EdgeInsets.all(20),
//                   decoration: new BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Icon(
//                     Icons.add,
//                     size: 50,
//                     color: ColorConstant.brownGrey,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
