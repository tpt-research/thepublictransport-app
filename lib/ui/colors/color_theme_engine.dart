import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

class ColorThemeEngine {

  static String theme = PrefService.getString('ui_theme') == "dark" ? "dark" : "light";

  static LinearGradient tptgradient_default = new LinearGradient(
    colors: [
      Colors.purple[300],
      Colors.pink[600]
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight
  );

  static LinearGradient tptfabgradient_default = new LinearGradient(
      colors: [
        Colors.purple[500],
        Colors.pink[800]
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight
  );

  static RadialGradient tptbottomgradient_default = new RadialGradient(
    center: Alignment.topLeft,
    radius: 0.5,
    colors: [
      Colors.purple[500],
      Colors.pink[800]
    ],
    tileMode: TileMode.repeated,
  );

  static LinearGradient get tptgradient {
    return tptgradient_default;
  }

  static LinearGradient get tptfabgradient {
    return tptfabgradient_default;
  }

  static RadialGradient get tptbottomgradient {
    return tptbottomgradient_default;
  }

  static Color get backgroundColor {
    if (theme == "dark")
      return Colors.black;
    else
      return Colors.white;
  }

  static Color get cardColor {
    if (theme == "dark")
      return Colors.black;
    else
      return Colors.white;
  }

  static Color get titleColor {
    if (theme == "dark")
      return Colors.grey[300];
    else
      return Colors.grey;
  }

  static Color get subtitleColor {
    if (theme == "dark")
      return Colors.grey[300];
    else
      return Colors.grey;
  }

  static Color get textColor {
    if (theme == "light")
      return Colors.black;
    else
      return Colors.white;
  }

  static Color get iconColor {
    if (theme == "light")
      return Colors.black;
    else
      return Colors.white;
  }

  static BorderSide decideBorderSide() {
    if (theme == "dark")
      return BorderSide(
          color: textColor
      );
    else
      return BorderSide(
        color: Colors.transparent
    );;
  }

  static Color fancybottomcolor = Colors.purple[300];
}