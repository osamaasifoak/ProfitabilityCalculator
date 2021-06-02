import 'package:flutter/cupertino.dart';
import 'package:lichtline/providers/data_provider.dart';
import 'package:lichtline/providers/user_provider.dart';
import 'package:provider/provider.dart';

providersList(BuildContext context) {
  return [
    ChangeNotifierProvider(
      create: (context) => DataProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ];
}
