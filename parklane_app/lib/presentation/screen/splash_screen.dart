import 'package:flutter/material.dart';
import '../widgets/gobals/responsive_layout.dart';

class SplashScreen extends StatelessWidget {
  static const String route = '/splash-Screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FlutterLogo(
            size: 30,
          ),
          Text(
            'Parklane',
            style: Theme.of(context).textTheme.headline3,
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("go back"))
        ],
      )),
    );
  }
}
