import 'package:flutter/material.dart';

class ColorConstants {

  static LinearGradient tptgradient = new LinearGradient(
    colors: [
      Colors.purple[300],
      Colors.pink[600]
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight
  );

  static LinearGradient tptfabgradient = new LinearGradient(
      colors: [
        Colors.purple[500],
        Colors.pink[800]
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight
  );

  static RadialGradient tptbottomgradient = new RadialGradient(
    center: Alignment.topLeft,
    radius: 0.5,
    colors: [
      Colors.purple[500],
      Colors.pink[800]
    ],
    tileMode: TileMode.repeated,
  );

  static Color fancybottomcolor = Colors.purple[300];
}