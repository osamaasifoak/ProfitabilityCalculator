import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/ui_utils/size_config.dart';

class ImagePlaceHolderComponent extends StatelessWidget {
  final List<File> placeHolder;
  final Function(int imageIndex) onTapRemove;
  const ImagePlaceHolderComponent({Key key, this.placeHolder, this.onTapRemove})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Wrap(
      children: [
        for (var i = 0; i < placeHolder.length; i++)
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: i != placeHolder.length - 1 ? 8.0 : 0.0, bottom: 10),
                child: Container(
                  height: SizeConfig.screenHeight / 9.5,
                  width: SizeConfig.screenWidth / 4.8,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(placeHolder[i].path),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -2,
                child: InkWell(
                  onTap: () => onTapRemove(i),
                  child: Icon(
                    Icons.cancel_sharp,
                    color: ColorConstant.greyishBrownTwo,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
