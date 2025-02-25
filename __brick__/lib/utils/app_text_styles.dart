import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import './app_utils.dart';

class AppTextStyle {
  static TextTheme getTextTheme() =>
      GoogleFonts.getTextTheme('{{google_fonts_name}}');

  // To use text default style for whole app add style in GetMaterialApp widget
  // theme: ThemeData(textTheme: AppTextStyle.getTextTheme())

  static TextStyle _getTextStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
  }) =>
      GoogleFonts.getFont(
        '{{google_fonts_name}}',
        textStyle: TextStyle(
          fontSize: fontSize,
          color: color ?? AppColors.primary,
          fontWeight: fontWeight ?? FontWeight.w400,
        ),
      );

  static TextStyle get textSize16Bold => _getTextStyle(
        fontSize: AppDimens.dimens16.sp,
        color: AppColors.colorWhite,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get textSize24SemiBold => _getTextStyle(
        fontSize: AppDimens.dimens24.sp,
        color: AppColors.colorBlack,
        fontWeight: FontWeight.w600,
      );
}
