// This is Deprecated and will be removed soon.

import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

class ColorThemeEngine {
  static String theme =
      PrefService.getString('ui_theme') == "dark" ? "dark" : "light";
  static String accent = PrefService.getString('accent_theme') ?? "default";

  static LinearGradient tptgradient_default = new LinearGradient(
      colors: [Colors.purple[400], Colors.pink[600]],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  static LinearGradient tptfabgradient_default = new LinearGradient(
      colors: [Colors.purple[500], Colors.pink[800]],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  static RadialGradient tptbottomgradient_default = new RadialGradient(
    center: Alignment.topLeft,
    radius: 0.5,
    colors: [Colors.purple[500], Colors.pink[800]],
    tileMode: TileMode.repeated,
  );

  static LinearGradient tptgradient_falcon = new LinearGradient(
      colors: [Colors.blue[400], Colors.yellow[600]],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  static LinearGradient tptfabgradient_falcon = new LinearGradient(
      colors: [Colors.blue[500], Colors.yellow[800]],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  static RadialGradient tptbottomgradient_falcon = new RadialGradient(
    center: Alignment.topLeft,
    radius: 0.5,
    colors: [Colors.blue[500], Colors.yellow[800]],
    tileMode: TileMode.repeated,
  );

  static LinearGradient tptgradient_charme = new LinearGradient(
      colors: [Colors.blue[400], Colors.red[600]],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  static LinearGradient tptfabgradient_charme = new LinearGradient(
      colors: [Colors.blue[500], Colors.red[800]],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  static RadialGradient tptbottomgradient_charme = new RadialGradient(
    center: Alignment.topLeft,
    radius: 0.5,
    colors: [Colors.blue[500], Colors.red[800]],
    tileMode: TileMode.repeated,
  );

  static LinearGradient tptgradient_sun = new LinearGradient(
      colors: [Colors.yellow[400], Colors.orange[600]],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  static LinearGradient tptfabgradient_sun = new LinearGradient(
      colors: [Colors.yellow[500], Colors.orange[800]],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  static RadialGradient tptbottomgradient_sun = new RadialGradient(
    center: Alignment.topLeft,
    radius: 0.5,
    colors: [Colors.yellow[500], Colors.orange[800]],
    tileMode: TileMode.repeated,
  );

  static LinearGradient tptgradient_pride = new LinearGradient(colors: [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  static LinearGradient tptfabgradient_pride = new LinearGradient(colors: [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  static RadialGradient tptbottomgradient_pride = new RadialGradient(
    center: Alignment.topCenter,
    radius: 0.5,
    colors: [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.purple
    ],
    tileMode: TileMode.repeated,
  );

  static LinearGradient get tptgradient {
    switch (accent) {
      case "default":
        return tptgradient_default;
      case "falcon":
        return tptgradient_falcon;
      case "charme":
        return tptgradient_charme;
      case "sun":
        return tptgradient_sun;
      case "pride":
        return tptgradient_pride;
      default:
        return tptgradient_default;
    }
  }

  static LinearGradient get tptfabgradient {
    switch (accent) {
      case "default":
        return tptfabgradient_default;
      case "falcon":
        return tptfabgradient_falcon;
      case "charme":
        return tptfabgradient_charme;
      case "sun":
        return tptfabgradient_sun;
      case "pride":
        return tptfabgradient_pride;
      default:
        return tptfabgradient_default;
    }
  }

  static RadialGradient get tptbottomgradient {
    switch (accent) {
      case "default":
        return tptbottomgradient_default;
      case "falcon":
        return tptbottomgradient_falcon;
      case "charme":
        return tptbottomgradient_charme;
      case "sun":
        return tptbottomgradient_sun;
      case "pride":
        return tptbottomgradient_pride;
      default:
        return tptbottomgradient_default;
    }
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
      return BorderSide(color: textColor);
    else
      return BorderSide(color: Colors.transparent);
    ;
  }

  static Color fancybottomcolor = Colors.purple[300];
}
