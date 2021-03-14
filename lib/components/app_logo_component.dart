import 'package:flutter/material.dart';
import 'package:lichtline/constants/assets/assets_constants.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      child: Image.asset(AssetConstant.logo),
    );
  }
}
