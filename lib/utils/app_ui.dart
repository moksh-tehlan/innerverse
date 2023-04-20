import 'package:flutter/cupertino.dart';

class ScreenUtils{
  static const double screenHeight = 817;
  static const double screenWidth = 465;
}

extension ResponsiveIntegerConstraints on num{
  double toResponsiveHeight(BuildContext context) {
    return this * context.screenHeight / ScreenUtils.screenHeight;
  }

  double toResponsiveWidth(BuildContext context) {
    return this * context.screenWidth / ScreenUtils.screenWidth;
  }
}

extension ScreenDimension on BuildContext{
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
}