import 'package:flutter/painting.dart';
import 'app_fonts.dart';

class AppStyles {
  static TextStyle _getTextStyle(
    double fontSize,
    String fontFamily,
    FontWeight fontWeight,
  ) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
    );
  }

  static TextStyle getLightStyle({double fontSize = AppFontSize.s14}) =>
      _getTextStyle(fontSize, AppFonts.fontFamily, AppFontWeightManager.light);
  static TextStyle getRegularStyle({double fontSize = AppFontSize.s14}) =>
      _getTextStyle(
        fontSize,
        AppFonts.fontFamily,
        AppFontWeightManager.regular,
      );
  static TextStyle getBoldStyle({double fontSize = AppFontSize.s14}) =>
      _getTextStyle(fontSize, AppFonts.fontFamily, AppFontWeightManager.bold);
}
