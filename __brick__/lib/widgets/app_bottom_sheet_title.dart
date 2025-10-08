import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_utils.dart';
import './app_widget.dart';

class AppBottomSheetTitle extends StatelessWidget {
  const AppBottomSheetTitle({
    super.key,
    required this.title,
    required this.onClosePressed,
  });

  final String title;
  final VoidCallback? onClosePressed;

  @override
  Widget build(BuildContext context) {
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
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyle.textSize18Bold,
            ),
          ),
          if (onClosePressed != null)
            Material(
              color: AppColors.colorTransparent,
              child: InkWell(
                onTap: onClosePressed,
                borderRadius: BorderRadius.circular(
                  AppDimens.dimens20.r,
                ),
                child: Padding(
                  padding: EdgeInsets.all(
                    AppDimens.dimens15.h,
                  ),
                  child: AppImageView(
                    imagePath: AppAssets.icClose,
                    height: AppDimens.dimens12.w,
                    width: AppDimens.dimens12.w,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
