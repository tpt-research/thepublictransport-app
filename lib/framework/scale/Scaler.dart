import 'package:flutter/material.dart';

class Scaler {

  static double heightScaling(BuildContext context, num scale) {

    if (MediaQuery.of(context).size.height < 800)
      return MediaQuery.of(context).size.height * (scale + 0.10);

    return MediaQuery.of(context).size.height * scale;
  }

  static double heightDeScaling(BuildContext context, num scale) {
    if (MediaQuery.of(context).size.height < 800)
      return MediaQuery.of(context).size.height * (scale - 0.05);

    return MediaQuery.of(context).size.height * scale;
  }

  static double heightDeScalingCustom(BuildContext context, num scale, num subtract) {

    if (MediaQuery.of(context).size.height < 800)
      return MediaQuery.of(context).size.height * (scale - subtract);

    return MediaQuery.of(context).size.height * scale;
  }

}