import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_utils.dart';
import './in_app_update_page.dart';
import './in_app_update_controller.dart';

class ShowInAppUpdate {
  Future<void> showBottomSheet() async {
    if (Get.isRegistered<InAppUpdateController>()) {
      debugPrint('update dialog is already showing!');
      return;
    }
    debugPrint('showing update dialog!');
    Get.put(InAppUpdateController());
    await Get.bottomSheet(
      const SafeArea(
        child: InAppUpdatePage(),
      ),
      isDismissible: false,
      enableDrag: false,
      barrierColor: AppColors.colorBarrier,
      backgroundColor: AppColors.colorWhite,
    ).whenComplete(() {
      Get.delete<InAppUpdateController>();
    });
  }
}
