import 'dart:async';

import 'package:get/get.dart';

import '../../localizations/language_keys.dart';
import '../../utils/app_utils.dart';

class SplashController extends GetxController {
  RxString appName = ''.obs;

  @override
  void onInit() async {
    _updateAppName();
    _initSplash();
    super.onInit();
  }

  void _updateAppName() {
    appName.value = LanguageKey.appName.tr;
  }

  void _initSplash() async {
    await Future.delayed(
      const Duration(seconds: AppConfig.splashTimer),
    ).then((value) async {
      _navigateToScreen();
    });
  }

  void _navigateToScreen() {}
}
