import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../localizations/language_keys.dart';
import '../utils/app_utils.dart';

class AppNoInternetView extends StatelessWidget {
  const AppNoInternetView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.dimensScreenHorizontalMargin.w,
          ),
          child: Center(
            child: Text(
              LanguageKey.noInternetConnection.tr,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
