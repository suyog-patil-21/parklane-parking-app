import 'package:flutter/material.dart';

// Button Shape
final buttonShape =
    MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(12.0),
));

// Shape for BottomSheet, Dialog box , etc
final customShpaeUIElements =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(24));
