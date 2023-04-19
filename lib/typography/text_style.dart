import 'package:flutter/material.dart';
part 'font_weights.dart';

extension CustomTextStyle on BuildContext{
  TextStyle get textStyle => Theme.of(this).textTheme.bodyMedium!.poppins;
}

extension FontFamilyExtension on TextStyle {
  TextStyle get poppins => copyWith(fontFamily: 'poppins');
}

extension TextStyleExtension on TextStyle {
  TextStyle withOpacity(double opacity) =>
      copyWith(color: color!.withOpacity(opacity));
  TextStyle withColor(Color newColor) => copyWith(color: newColor);
}

extension FontWeightExtension on TextStyle {
  TextStyle get bold => copyWith(fontWeight: CustomFontWeights.bold);
  TextStyle get semiBold => copyWith(fontWeight: CustomFontWeights.semiBold);
  TextStyle get medium => copyWith(fontWeight: CustomFontWeights.medium);
  TextStyle get light => copyWith(fontWeight: CustomFontWeights.light);
  TextStyle get regular => copyWith(fontWeight: CustomFontWeights.regular);
}

extension FontSizeExtension on TextStyle {
  TextStyle get size10 => copyWith(fontSize: 10);
  TextStyle get size11 => copyWith(fontSize: 11);
  TextStyle get size12 => copyWith(fontSize: 12);
  TextStyle get size13 => copyWith(fontSize: 13);
  TextStyle get size14 => copyWith(fontSize: 14);
  TextStyle get size15 => copyWith(fontSize: 15);
  TextStyle get size16 => copyWith(fontSize: 16);
  TextStyle get size17 => copyWith(fontSize: 17);
  TextStyle get size18 => copyWith(fontSize: 18);
  TextStyle get size19 => copyWith(fontSize: 19);
  TextStyle get size20 => copyWith(fontSize: 20);
  TextStyle get size21 => copyWith(fontSize: 21);
  TextStyle get size22 => copyWith(fontSize: 22);
  TextStyle get size23 => copyWith(fontSize: 23);
  TextStyle get size24 => copyWith(fontSize: 24);
  TextStyle get size25 => copyWith(fontSize: 25);
  TextStyle get size26 => copyWith(fontSize: 26);
  TextStyle get size27 => copyWith(fontSize: 27);
  TextStyle get size28 => copyWith(fontSize: 28);
  TextStyle get size29 => copyWith(fontSize: 29);
  TextStyle get size30 => copyWith(fontSize: 30);
  TextStyle get size31 => copyWith(fontSize: 31);
  TextStyle get size32 => copyWith(fontSize: 32);
  TextStyle get size33 => copyWith(fontSize: 33);
  TextStyle get size34 => copyWith(fontSize: 34);
  TextStyle get size35 => copyWith(fontSize: 35);
  TextStyle get size36 => copyWith(fontSize: 36);
  TextStyle get size37 => copyWith(fontSize: 37);
  TextStyle get size38 => copyWith(fontSize: 38);
  TextStyle get size39 => copyWith(fontSize: 39);
  TextStyle get size40 => copyWith(fontSize: 40);
  TextStyle get size41 => copyWith(fontSize: 41);
  TextStyle get size42 => copyWith(fontSize: 42);
  TextStyle get size43 => copyWith(fontSize: 43);
  TextStyle get size44 => copyWith(fontSize: 44);
  TextStyle get size45 => copyWith(fontSize: 45);
  TextStyle get size46 => copyWith(fontSize: 46);
}
