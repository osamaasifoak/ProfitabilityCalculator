import 'package:lichtline/screens/auth/login_screen.dart';
import 'package:lichtline/screens/auth/signup_screen.dart';
import 'package:lichtline/screens/certificate/certificate_screen.dart';
import 'package:lichtline/screens/economic_calculator/economic_calculator_screen.dart';
import 'package:lichtline/screens/home/bottom_bar_screen.dart';
import 'package:lichtline/screens/home/menu_selection_screen.dart';
import 'package:lichtline/screens/input_readings/company_name_screen.dart';
import 'package:lichtline/screens/input_readings/input_screen.dart';
import 'package:flutter/material.dart';
import 'package:lichtline/screens/umweltrechner/umweltrechner.dart';
import 'package:lichtline/splash_screen.dart';
import 'constants/routes/routes_constants.dart';

onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case RouteConstants.splashScreen:
      return MaterialPageRoute(
        builder: (_) => SplashScreen(),
      );
    case RouteConstants.login:
      return MaterialPageRoute(
        builder: (_) => LoginScreen(),
      );
    case RouteConstants.signup:
      return MaterialPageRoute(
        builder: (_) => SignupScreen(),
      );
    case RouteConstants.bottomBarScreen:
      return MaterialPageRoute(
        builder: (_) => BottomBarScreen(),
      );
    case RouteConstants.inputScreen:
      return MaterialPageRoute(
        builder: (_) => InputScreen(),
      );
    case RouteConstants.menuSelection:
      return MaterialPageRoute(
        builder: (_) => MenuSelectionScreen(),
      );
    case RouteConstants.economicCalculator:
      return MaterialPageRoute(
        builder: (_) => EconomicCalculatorScreen(),
      );
    case RouteConstants.umweltrechnerScreen:
      return MaterialPageRoute(
        builder: (_) => UmweltrechnerScreen(),
      );
    case RouteConstants.certificateScreen:
      return MaterialPageRoute(
        builder: (_) => CertificateScreen(),
      );
    case RouteConstants.companyNameScreen:
      return MaterialPageRoute(
        builder: (_) => CompanyNameScreen(),
      );
    default:
  }
}
