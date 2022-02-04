import 'package:flutter/material.dart';

class CustomColors {
  static const primaryVeryBlack = Color.fromRGBO(10, 18, 21, 1);
  static const primaryLight = Color.fromRGBO(73, 78, 81, 1);
  static const primaryBlack = Color.fromRGBO(47, 52, 55, 1);
  static const primary = Color.fromRGBO(55, 60, 63, 1);

  static final primarySwatch = MaterialColor(primary.value, const {
    50: primary,
    100: primary,
    200: primary,
    300: primary,
    400: primary,
    500: primary,
    600: primary,
    700: primary,
    800: primary,
    900: primary
  });
}
