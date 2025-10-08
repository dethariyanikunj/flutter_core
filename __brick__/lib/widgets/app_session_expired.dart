import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../localizations/language_keys.dart';
import '../utils/app_utils.dart';
import './app_widget.dart';

class AppSessionExpired {
  static bool isOpened = false;

  static void showBottomSheet() async {
    isOpened = true;
    _clearData();
    await Get.bottomSheet(
      const PopScope(
        canPop: false,
        child: SafeArea(
          child: SessionExpiredPage(),
        ),
      ),
      enableDrag: false,
      isDismissible: false,
      barrierColor: AppColors.colorBarrier,
      backgroundColor: AppColors.colorWhite,
    );
  }

  static void _clearData() {
    final prefObj = PrefUtils();
    prefObj.clearPreferencesData();
  }
}

class SessionExpiredPage extends StatelessWidget {
  const SessionExpiredPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _titleWidget(context),
        _contentWidget(),
      ],
    );
  }

  Widget _titleWidget(BuildContext context) {
    return AppBottomSheetTitle(
      title: LanguageKey.sessionExpired.tr,
      onClosePressed: null,
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
              LanguageKey.sessionExpiredMessage.tr,
              style: AppTextStyle.textSize16Regular,
            ),
            SizedBox(
              height: AppDimens.dimens20.h,
            ),
            _actionButtonWidget(),
          ],
        ));
  }

  Widget _actionButtonWidget() {
    return AppFilledButton(
      text: LanguageKey.loginAgain.tr,
      buttonStyle: AppButtonStyles().filledButtonTheme.style?.copyWith(
            backgroundColor: const WidgetStatePropertyAll(
              AppColors.colorFF0000,
            ),
          ),
      onPressed: () => _navigateToAuthScreen(),
    );
  }

  void _navigateToAuthScreen() {
    AppSessionExpired.isOpened = false;
    // TODO: Change Root
    Get.offAllNamed(AppRoutes.splashPage);
  }
}
