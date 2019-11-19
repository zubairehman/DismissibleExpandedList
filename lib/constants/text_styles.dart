import 'package:flutter/material.dart';

class TextStyles {
  TextStyles._();

  static TextStyle get titleSelected => TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      );

  static TextStyle get subTitleSelected => TextStyle(
        color: Colors.black87,
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
