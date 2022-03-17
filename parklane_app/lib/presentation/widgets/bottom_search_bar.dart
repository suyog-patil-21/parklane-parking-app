import 'package:flutter/material.dart';

class CustomBottomSearchBar extends StatelessWidget {
  const CustomBottomSearchBar({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipBehavior: Clip.hardEdge,
      clipper: BottomSearchBarCustomClipper(),
      child: BottomAppBar(
        elevation: 8,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            // alignment: Alignment.center,
            child: SafeArea(
              child: Row(children: [
                Icon(Icons.search),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    child: Container(
                  height: 50,
                  child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search the place...')),
                )),
                const SizedBox(
                  width: 10.0,
                ),
                Icon(
                  Icons.arrow_back_ios_new,
                )
              ]),
            )),
      ),
    );
  }
}

class BottomSearchBarCustomClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    var roundheight = size.height * 0.35;

    path.quadraticBezierTo(
        size.width, roundheight, size.width - roundheight, roundheight);
    path.lineTo(roundheight, roundheight);
    path.quadraticBezierTo(0, roundheight, 0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
