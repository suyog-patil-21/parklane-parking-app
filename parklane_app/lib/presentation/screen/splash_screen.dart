import 'package:flutter/material.dart';
import 'package:parklane_app/presentation/widgets/gobals/responsive_layout.dart';

class SplashScreen extends StatelessWidget {
  static const String route = '/splash-Screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const FlutterLogo(),
          Text(
            'Parklane',
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
      )),
    );
  }
}
