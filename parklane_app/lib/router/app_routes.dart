import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parklane_app/presentation/mobileui/mobile_login_intro_view.dart';
import 'package:parklane_app/presentation/mobileui/mobile_login_signup_view.dart';
import 'package:parklane_app/presentation/screen/home_screen.dart';
import 'package:parklane_app/presentation/screen/login_signup_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
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
        return null;
    }
  }
}
