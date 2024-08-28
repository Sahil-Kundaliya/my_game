import 'package:flutter/material.dart';

class DeviceSize {
  static Size? size;

  void setDeviceSize({required BuildContext context}) {
    size = MediaQuery.of(context).size;
  }
}
