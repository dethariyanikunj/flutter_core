import 'package:flutter/material.dart';

import './app_colors.dart';

class AppGradients {
  static const primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[AppColors.primary, AppColors.primary],
    tileMode: TileMode.mirror,
  );
}
