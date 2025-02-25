import 'package:flutter/services.dart';

import './app_utils.dart';

class AppThemeUtils {
  void setLightStatusBarStyle({
    Color? statusBarColor,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? AppColors.colorTransparent,
        // Dark icons and text on status bar
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  void setDarkStatusBarStyle({
    Color? statusBarColor,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? AppColors.colorTransparent,
        // Light icons and text on status bar
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }
}
