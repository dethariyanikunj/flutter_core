import 'package:flutter/material.dart';

import '../utils/app_utils.dart';

class AppDatePicker {
  static Future<DateTime?> selectDate({
    required BuildContext context,
    required DateTime initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime.now(),
      // Exclude today
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              // Header background and selected date
              primary: AppColors.primary,
              // Text color on selected date
              onPrimary: AppColors.colorWhite,
              // Text color for unselected dates
              onSurface: AppColors.colorBlack,
            ),
            dialogBackgroundColor: AppColors.colorWhite,
            // Background color of the dialog
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                // Button text color
                foregroundColor: AppColors.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
