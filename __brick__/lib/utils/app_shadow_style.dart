import 'package:flutter/material.dart';

import './app_colors.dart';

class AppShadowStyle {
  static List<BoxShadow> titleBarShadow() {
    return [
      BoxShadow(
        color: AppColors.colorBlack.withOpacity(0.05),
        spreadRadius: 5,
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ];
  }
}
