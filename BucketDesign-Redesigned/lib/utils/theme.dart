// Packages
import 'package:flutter/material.dart';

class CustomTheme {
  // Text colors
  static const Color uncoloredText = Color(0xFF8A9EA6);
  static const Color text = Color(0xFF18779C);

  // Widget colors
  static const Color mainColor = Color(0xFF2EC0F9);
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkBack = Color(0xFFE5E7EB);

  // Body background color
  static const Color background = Color(0xFFECEFF3);

  // Linear Gradient colors
  static const List<Color> mainGradient = [
    mainColor,
    Color(0xFF2EC0F9),
  ];


  // TextStyles
  static const TextStyle uncoloredTitle = TextStyle(
    color: uncoloredText,
    height: 0,
    fontSize: 24,
  );

  static const TextStyle coloredTitle = TextStyle(
    color: text,
    fontSize: 28,
    fontWeight: FontWeight.w800
  );

}
