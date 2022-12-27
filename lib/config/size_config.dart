import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double blockSizeHorizontal = 0;
  static double blockSizeVertical = 0;

  // static double _safeAreaHorizontal;
  // static double _safeAreaVertical;
  // static double safeBlockHorizontal;
  // static double safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    if ( _mediaQueryData == null ) { return; }

    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}