import 'package:flutter/painting.dart';
import 'app_fonts.dart';

class AppStyles {
  static TextStyle _getTextStyle(double fontSize, FontWeight fontWeight) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight);
  }

  static TextStyle getLightStyle({double fontSize = AppFonts.s14}) =>
      _getTextStyle(fontSize, AppFonts.light);
  static TextStyle getRegularStyle({double fontSize = AppFonts.s14}) =>
      _getTextStyle(fontSize, AppFonts.regular);
  static TextStyle getBoldStyle({double fontSize = AppFonts.s14}) =>
      _getTextStyle(fontSize, AppFonts.bold);
}
