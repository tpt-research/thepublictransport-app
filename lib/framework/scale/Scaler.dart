import 'package:flutter/material.dart';

class Scaler {

  static double heightScaling(BuildContext context, num scale) {

    if (MediaQuery.of(context).size.height >= 1600)
      return MediaQuery.of(context).size.height * scale + 0.10;

    return MediaQuery.of(context).size.height * scale;
  }

}