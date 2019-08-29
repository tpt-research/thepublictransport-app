import 'package:flutter/material.dart';

class Theme {

  final Color backgroundColor;
  final Color foregroundColor;
  final Color textColor;
  final Color titleColor;
  final Color titleColorInverted;
  final Color subtitleColor;
  final Color cardColor;
  final Color iconColor;
  final Color floatingActionButtonColor;
  final Color floatingActionButtonIconColor;
  final Brightness statusbarBrightness;
  final Brightness statusbarIconBrightness;
  final Brightness navbarIconBrightness;
  final String status;

  Theme(
      this.backgroundColor,
      this.foregroundColor,
      this.textColor,
      this.titleColor,
      this.titleColorInverted,
      this.subtitleColor,
      this.cardColor,
      this.iconColor,
      this.floatingActionButtonColor,
      this.floatingActionButtonIconColor,
      this.statusbarBrightness,
      this.statusbarIconBrightness,
      this.navbarIconBrightness,
      this.status
      );

  factory Theme.lightTheme() {
    return new Theme(
        Colors.white, // backgroundColor
        Colors.white, // foregroundColor
        Colors.black, // textColor
        Colors.black, // titleColor
        Colors.white, // titleColorInverted
        Colors.black38, // subtitleColor
        Colors.white, // cardColor
        Colors.black, // iconColor
        Colors.black, // floatingActionButtonColor
        Colors.white, // floatingActionButtonIconColor
        Brightness.light, // statusbarBrightness
        Brightness.dark, // statusbarIconBrightness
        Brightness.dark, // navbarIconBrightness
        "light"
    );
  }

  factory Theme.darkTheme() {
    return new Theme(
        Colors.black,
        Colors.black,
        Colors.white,
        Colors.white,
        Colors.black,
        Colors.white70,
        Colors.grey[900],
        Colors.white,
        Colors.white,
        Colors.black,
        Brightness.dark,
        Brightness.light,
        Brightness.light,
        "dark"
    );
  }
}