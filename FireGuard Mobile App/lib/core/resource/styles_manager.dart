import 'package:fire_guard_app/core/resource/fonts_manager.dart';
import 'package:flutter/material.dart';

class StylesManager {
  // ------------------<<Font Family>>------------------

  // ------------------<<Inter Font Family Text Styles>>------------------
  static TextStyle interFontFamilyRegular({
    required double fontSize,
    required Color color,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return TextStyle(
      fontFamily: FontsManager.interFontFamily,
      color: color,
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle interFontFamilyMedium({
    required double fontSize,
    required Color color,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return TextStyle(
      fontFamily: FontsManager.interFontFamily,
      color: color,
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle interFontFamilyExtraBold({
    required double fontSize,
    required Color color,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return TextStyle(
        fontFamily: FontsManager.interFontFamily,
        fontSize: fontSize,
        color: color,
        fontStyle: fontStyle,
        fontWeight: FontWeight.w800);
  }

  static TextStyle interFontFamilyBold({
    required double fontSize,
    required Color color,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return TextStyle(
        color: color,
        fontFamily: FontsManager.interFontFamily,
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: FontWeight.w700);
  }
}
