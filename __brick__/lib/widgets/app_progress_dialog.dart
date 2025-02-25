import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_utils.dart';

class AppProgressDialog {
  static bool _isShowing = false;

  /// Show the progress dialog
  static void show() {
    if (!_isShowing) {
      _isShowing = true;
      Get.dialog(
        barrierDismissible: false, // Prevent dismiss on tapping outside
        barrierColor: AppColors.colorTransparent,
        const PopScope(
          canPop: false, // Disable back press
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ), // Progress indicator
            ),
          ),
        ),
      );
    }
  }

  /// Hide the progress dialog
  static void hide() {
    if (_isShowing) {
      _isShowing = false;
      Get.back(); // Close the dialog
    }
  }
}
