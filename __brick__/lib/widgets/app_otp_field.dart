import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../utils/app_utils.dart';

class AppOtpField extends StatelessWidget {
  const AppOtpField({
    super.key,
    required this.textEditingController,
    required this.focusNode,
    required this.onOtpTextCompleted,
  });

  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final Function(String) onOtpTextCompleted;

  PinTheme _defaultPinTheme() {
    return PinTheme(
      width: AppDimens.dimensOtpInputFieldSize.w,
      height: AppDimens.dimensOtpInputFieldSize.h,
      textStyle: AppTextStyle.textSize24SemiBold,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppDimens.dimensOutlinedInputFieldRadius.h,
        ),
        border: Border.all(
          color: AppColors.colorE0E0E0,
          width: 1,
        ),
        color: AppColors.colorWhite,
      ),
    );
  }

  PinTheme _focusedPinTheme() {
    return _defaultPinTheme().copyWith(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppDimens.dimensOutlinedInputFieldRadius.h,
        ),
        border: Border.all(
          color: AppColors.primary,
          width: 1,
        ),
        color: AppColors.colorF0F7FC,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: textEditingController,
      focusNode: focusNode,
      length: AppConfig.mobileOtpLength,
      autofocus: true,
      separatorBuilder: (index) => _separatorWidget(),
      defaultPinTheme: _defaultPinTheme(),
      showCursor: true,
      cursor: _cursorWidget(),
      focusedPinTheme: _focusedPinTheme(),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: onOtpTextCompleted,
    );
  }

  Widget _separatorWidget() {
    return Container(
      height: AppDimens.dimensOtpInputFieldSize.h,
      width: AppDimens.dimens15.w,
      color: AppColors.colorTransparent,
    );
  }

  Widget _cursorWidget() {
    return SizedBox(
      height: AppDimens.dimens30.h,
      child: VerticalDivider(
        color: AppColors.primary,
        width: AppDimens.dimens2.w,
        thickness: AppDimens.dimens2.w,
      ),
    );
  }
}
