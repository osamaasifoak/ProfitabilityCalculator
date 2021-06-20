import 'package:firebase_core/firebase_core.dart';
import 'package:lichtline/constants/colors/colors_constants.dart';
import 'package:lichtline/provider_initialize_list.dart';
import 'package:lichtline/routes.dart';
import 'package:flutter/material.dart';
import 'package:lichtline/splash_screen.dart';
import 'package:provider/provider.dart';
import 'splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providersList(context),
      child: MaterialApp(
        title: 'lichtline',
        theme: ThemeData(
          primarySwatch: ColorConstant.kPrimaryColor,
          primaryColor: ColorConstant.kPrimaryColor,
          dialogTheme: DialogTheme(backgroundColor: ColorConstant.black),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: (RouteSettings settings) {
          return onGenerateRoutes(settings);
        },
        home: SplashScreen(),
        // home: AnimationScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
