import 'package:flutter/material.dart';

class TextStyles {
  TextStyles._();

  static TextStyle get titleSelected => TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );

  static TextStyle get subTitleSelected => TextStyle(
        color: Colors.white,
        fontSize: 12.0,
      );

  static TextStyle get title => TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        color: Colors.black54,
      );

  static TextStyle get subTitle => TextStyle(
        color: Colors.black54,
        fontSize: 12.0,
      );
}
