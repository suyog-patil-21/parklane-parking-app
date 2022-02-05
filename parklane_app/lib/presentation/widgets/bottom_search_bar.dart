import 'package:flutter/material.dart';

class CustomBottomSearchBar extends StatelessWidget {
  const CustomBottomSearchBar({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height * 0.1,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
      // color: Colors.red,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(Icons.search_rounded),
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Parking address...'),
              keyboardType: TextInputType.url,
            ),
          ),
          Icon(
            Icons.arrow_back_ios_new,
            size: 16,
          )
        ],
      ),
    );
  }
}
