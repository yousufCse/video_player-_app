import 'package:flutter/material.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late MediaQueryData _mediaQueryData;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }

  double getProportionalScreenHeight(double height) {
    double screenHeight = SizeConfig.screenHeight;
    return (height / 812.0) * screenHeight;
  }

  double getProportionalScreenWidth(double width) {
    double screenWidth = SizeConfig.screenWidth;
    return (width / 375.0) * screenWidth;
  }
}
