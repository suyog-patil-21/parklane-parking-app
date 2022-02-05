import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parklane_app/presentation/screen/home_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        // * Home Screen Route
        return MaterialPageRoute(builder: (_) => HomeScreen());
        break;
      default:
        return null;
    }
  }
}
