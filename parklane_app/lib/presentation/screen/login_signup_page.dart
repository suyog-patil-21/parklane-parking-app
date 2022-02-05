import 'package:flutter/material.dart';
import '../desktopui/desktop_login_view.dart';
import '../mobileui/mobile_login_view.dart';
import '../widgets/gobals/responsive_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        backgroundColor: Colors.amberAccent.shade100,
        body: ResponsiveLayout(
          desktopBody: DesktopLoginView(),
          mobileBody: MobileLoginView(),
        ));
  }
}
