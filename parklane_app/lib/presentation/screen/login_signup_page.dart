import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/internet_status_cubit/internet_cubit.dart';

import '../desktopui/desktop_login_view.dart';
import '../mobileui/mobile_login_intro_view.dart';
import '../widgets/gobals/responsive_layout.dart';

class LoginSignupScreen extends StatelessWidget {
  static const String route = '/auth';
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktopBody: DesktopLoginView(),
      mobileBody: MobileLoginIntroView(),
    );
  }
}
