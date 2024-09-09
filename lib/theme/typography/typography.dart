import 'package:flutter/material.dart';
import 'package:habits/theme/palette/palette.dart';

class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontFamily: 'Inter',
    fontSize: 34,
    fontWeight: FontWeight.bold,
    color: Palette.black,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Palette.black,
  );

  static const TextStyle bodyText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    color: Colors.black54,
  );

  static const TextStyle inputText = TextStyle(
    fontSize: 16,
    color: Palette.gray200,
  );

  static const TextStyle placeholder = TextStyle(
    fontSize: 16,
    color: Palette.gray200,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    color: Palette.black,
  );

  static const TextStyle link = TextStyle(
    fontSize: 14,
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );
}
