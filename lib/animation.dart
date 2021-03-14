import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/ui_utils/size_config.dart';

class AnimationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        color: ColorConstant.greyishBrownThree,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _AnimatedClouds(
              duration: 20,
            ),
            _AnimatedClouds(
              duration: 10,
            ),
            Positioned(
              bottom: -50,
              child: _AnimatedClouds(
                duration: 15,
                positionedTop: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedClouds extends StatefulWidget {
  final int duration;
  final double positionedTop;
  final double positionedLeft;
  final double positionedRight;
  const _AnimatedClouds(
      {Key key,
      this.duration = 10,
      this.positionedTop = 10,
      this.positionedLeft,
      this.positionedRight})
      : super(key: key);
  @override
  __AnimatedCloudsState createState() => __AnimatedCloudsState();
}

class __AnimatedCloudsState extends State<_AnimatedClouds> {
  double _cloudStart = 0;
  double _cloudEnd = 2;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: _cloudStart, end: _cloudEnd),
      duration: Duration(seconds: widget.duration),
      child: Stack(
        children: [
          Image.asset(
            "assets/cloud.png",
            width: SizeConfig.screenWidth * 0.4,
          ),
          Positioned(
            left: 40,
            top: widget.positionedTop,
            child: Image.asset(
              "assets/cloud.png",
              width: SizeConfig.screenWidth * 0.3,
            ),
          )
        ],
      ),
      onEnd: () {
        setState(() {
          _cloudStart = _cloudStart * pi;
          if (_cloudEnd >= SizeConfig.screenWidth) {
            _cloudEnd = -SizeConfig.screenWidth;
          } else {
            _cloudEnd = SizeConfig.screenWidth;
          }
        });
      },
      builder: (_, double values, child) {
        return Transform.translate(
          offset: Offset(values, 0),
          child: child,
        );
      },
    );
  }
}
