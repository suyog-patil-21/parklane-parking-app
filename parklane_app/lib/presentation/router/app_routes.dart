import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../screen/splash_screen.dart';
import '../mobileui/mobile_login_intro_view.dart';
import '../mobileui/mobile_login_signup_view.dart';
import '../screen/home_screen.dart';
import '../screen/login_signup_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case SplashScreen.route:
        // * Splash Screen Route : '/splash-Screen'
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case HomeScreen.route:
        // * Home Screen Route : '/'
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case LoginSignupScreen.route:
        // * LoginSignupSCreen Routes: '/auth'
        return MaterialPageRoute(builder: (_) => LoginSignupScreen());
      case MobileLoginIntroView.route:
        // * MobileSignupIntroScreenRoute: '/mobileauthintro'
        return MaterialPageRoute(builder: (_) => MobileLoginIntroView());
      case MobileLoginSignupView.route:
        // * Mobile Login / Signup Screen route : '/mobileauth'
        return MaterialPageRoute(builder: (_) => MobileLoginSignupView());
      default:
        // return null;
        // for return a error page
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('Error Routing see into AppRoute'),
        ),
      );
    });
  }
}
