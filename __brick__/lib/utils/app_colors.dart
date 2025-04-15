import 'package:flutter/material.dart';

class AppColors {
  static MaterialColor primaryPalette = MaterialColor(
    primary.value,
    <int, Color>{
      50: primary.withAlpha(10),
      100: primary.withAlpha(20),
      200: primary.withAlpha(30),
      300: primary.withAlpha(40),
      400: primary.withAlpha(50),
      500: primary.withAlpha(60),
      600: primary.withAlpha(70),
      700: primary.withAlpha(80),
      800: primary.withAlpha(90),
      900: primary.withAlpha(100),
    },
  );

  static const Color primary = Color(0xff007CC3);
  static const Color colorWhite = Colors.white;
  static const Color colorBlack = Colors.black;
  static const Color colorE0E0E0 = Color(0xffE0E0E0);
  static const Color colorF0F7FC = Color(0xffF0F7FC);
  static const Color color6C6C6C = Color(0xff6C6C6C);
  static Color colorBarrier = colorBlack.withOpacity(0.6);
  static const Color colorTransparent = Colors.transparent;
}
