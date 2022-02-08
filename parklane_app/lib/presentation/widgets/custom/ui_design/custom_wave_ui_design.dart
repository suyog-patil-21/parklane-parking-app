import 'package:flutter/material.dart';

class LoginWaveUiDesignClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.90);

    path.quadraticBezierTo(size.width * 0.15, size.height * 0.8,
        size.width * 0.54, size.height * 0.90);
    path.quadraticBezierTo(
        size.width * 0.79, size.height * 0.98, size.width, size.height * 0.85);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SignUpWaveUiDesignClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.85);

    path.quadraticBezierTo(size.width * 0.10, size.height * 0.80,
        size.width * 0.3, size.height * 0.9);
    path.quadraticBezierTo(size.width * 0.4, size.height * 0.96,
        size.width * 0.56, size.height * 0.91);
    path.quadraticBezierTo(
        size.width * 0.76, size.height * 0.78, size.width, size.height * 0.94);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
