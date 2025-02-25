import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './app_utils.dart';

class AppButtonStyles {
  FilledButtonThemeData get filledButtonTheme => FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimens.dimensButtonCornerRadius.h,
            ),
          ),
          elevation: 0,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
          textStyle: AppTextStyle.textSize16Bold,
        ),
      );

  OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.colorWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimens.dimensButtonCornerRadius.h,
            ),
          ),
          side: const BorderSide(
            color: AppColors.colorBlack,
          ),
          elevation: 0,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
          textStyle: AppTextStyle.textSize16Bold,
        ),
      );
}
