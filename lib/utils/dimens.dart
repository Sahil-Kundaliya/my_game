import 'dart:developer';

import 'package:flutter/material.dart';

class Dimenstions {
  static final Dimenstions _dimenstions = Dimenstions();
  static get instance => _dimenstions;

  double screenHeight = 0.0;
  double screenWidth = 0.0;

  void setDimens(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    screenWidth = size.width;
    screenHeight = size.height;

    log("Sahil:: Screen Height - $screenHeight | Screen Width - $screenWidth");
  }
}
