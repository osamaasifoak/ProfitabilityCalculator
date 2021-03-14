import 'package:flutter/material.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';

class ContainerCard extends StatelessWidget {
  final Widget child;
  final Color color;
  const ContainerCard({Key key, this.child, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: color != null ? color : ColorConstant.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: child,
    );
  }
}
