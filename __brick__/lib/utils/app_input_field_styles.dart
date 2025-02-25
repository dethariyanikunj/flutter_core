import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './app_utils.dart';

class AppInputFieldStyles {

  // Default Border
  OutlineInputBorder get outlineInputFieldBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppDimens.dimensOutlinedInputFieldRadius.h,
        ),
        borderSide: const BorderSide(
          color: AppColors.colorBlack,
          width: 1,
        ),
      );

  // Border once text in it
  OutlineInputBorder get outlineInputFieldEnabledBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppDimens.dimensOutlinedInputFieldRadius.h,
        ),
        borderSide: const BorderSide(
          color: AppColors.colorBlack,
          width: 1,
        ),
      );

  // Border with focus mode on
  OutlineInputBorder get outlineInputFieldFocusedBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppDimens.dimensOutlinedInputFieldRadius.h,
        ),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1,
        ),
      );

  // Border with error mode
  OutlineInputBorder get outlineInputFieldErrorBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      AppDimens.dimensOutlinedInputFieldRadius.h,
    ),
    borderSide: const BorderSide(
      color: AppColors.primary,
      width: 1,
    ),
  );
}
