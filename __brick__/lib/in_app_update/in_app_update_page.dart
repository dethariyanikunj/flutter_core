import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../localizations/language_keys.dart';
import '../../utils/app_utils.dart';
import '../../widgets/app_widget.dart';
import './in_app_update_controller.dart';

class InAppUpdatePage extends GetView<InAppUpdateController> {
  const InAppUpdatePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _titleWidget(context),
          _contentWidget(),
        ],
      ),
    );
  }

  Widget _titleWidget(BuildContext context) {
    return Container(
      height: AppDimens.dimensBottomSheetTitleHeight.h,
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            AppDimens.dimens10.r,
          ),
          topRight: Radius.circular(
            AppDimens.dimens10.r,
          ),
        ),
        boxShadow: AppShadowStyle.titleBarShadow(),
      ),
      padding: EdgeInsets.only(
        left: AppDimens.dimensScreenHorizontalMargin.w,
        right: AppDimens.dimens5.w,
      ),
      child: Text(
        LanguageKey.updateRequired.tr,
        style: AppTextStyle.textSize18Bold,
      ),
    );
  }

  Widget _contentWidget() {
    return Padding(
      padding: EdgeInsets.only(
        top: AppDimens.dimens15.h,
        bottom: AppDimens.dimens30.h,
        left: AppDimens.dimensScreenHorizontalMargin.w,
        right: AppDimens.dimensScreenHorizontalMargin.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LanguageKey.updateAvailable.tr,
            style: AppTextStyle.textSize16SemiBold,
          ),
          SizedBox(
            height: AppDimens.dimens15.h,
          ),
          Text(
            LanguageKey.updateNotes.tr,
            style: AppTextStyle.textSize16Regular.copyWith(
              color: AppColors.color6C6C6C,
            ),
          ),
          SizedBox(
            height: AppDimens.dimens20.h,
          ),
          _actionButtonWidget(),
        ],
      ),
    );
  }

  Widget _actionButtonWidget() {
    return AppFilledButton(
      text: LanguageKey.updateNow.tr,
      buttonStyle: AppButtonStyles().filledButtonTheme.style?.copyWith(
        backgroundColor: const WidgetStatePropertyAll(
          AppColors.primary,
        ),
      ),
      onPressed: () => controller.updateApp(),
    );
  }
}
