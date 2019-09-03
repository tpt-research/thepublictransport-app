import 'package:flutter/material.dart';

class PredefinedColors {

  static LinearGradient getFlixbusGradient() {
    return LinearGradient(
        colors: [
          Colors.lightGreen[400],
          Colors.lightGreen
        ]
    );
  }

  static LinearGradient getDBGradient() {
    return LinearGradient(
        colors: [
          Colors.red,
          Colors.redAccent
        ]
    );
  }

  static LinearGradient getICEGradient() {
    return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.black,
          Colors.red
        ]
    );
  }
}