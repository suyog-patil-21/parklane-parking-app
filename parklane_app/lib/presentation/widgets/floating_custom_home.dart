import 'package:flutter/material.dart';
import '../screen/splash_screen.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SplashScreen.route);
            },
            child: Icon(Icons.ac_unit),
          ),
          Card(
            child: Container(
              color: Colors.white,
              height: 60,
              width: screenSize.width * 0.24,
            ),
          )
        ],
      ),
    );
  }
}
