import 'package:flutter/material.dart';

class HomeScreenButtons extends StatelessWidget {
  HomeScreenButtons(
      {Key? key, required this.label, required this.icon, this.onPressed})
      : super(key: key);
  VoidCallback? onPressed;
  Icon icon;
  String label;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        // style: OutlinedButton.styleFrom(shape: ),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [icon, Text(label)],
        ));
  }
}
