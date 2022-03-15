import 'package:flutter/material.dart';

import '../desktopui/desktop_login_view.dart';
import '../mobileui/mobile_login_intro_view.dart';
import '../widgets/gobals/responsive_layout.dart';

class LoginSignupScreen extends StatelessWidget {
  static const String route = '/auth';
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // extendBodyBehindAppBar: true,
        child: ResponsiveLayout(
      desktopBody: DesktopLoginView(),
      mobileBody: MobileLoginIntroView(),
    ));
  }
}
