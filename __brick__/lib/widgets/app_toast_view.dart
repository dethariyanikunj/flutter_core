import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../localizations/language_keys.dart';

class AppToastView {
  static const int _toastCloseDuration = 3;

  static void showSuccessToast({
    required String? message,
  }) {
    if (message != null && message.trim().isNotEmpty) {
      toastification.show(
        title: Text(
          message.trim(),
          maxLines: 2,
        ),
        autoCloseDuration: const Duration(
          seconds: _toastCloseDuration,
        ),
        style: ToastificationStyle.flatColored,
        type: ToastificationType.success,
      );
    }
  }

  static void showErrorToast({
    String? message,
  }) {
    toastification.show(
      title: Text(
        message?.trim() ?? LanguageKey.oopsSomethingWentWrong.tr,
        maxLines: 2,
      ),
      autoCloseDuration: const Duration(
        seconds: _toastCloseDuration,
      ),
      style: ToastificationStyle.flatColored,
      type: ToastificationType.error,
    );
  }
}
