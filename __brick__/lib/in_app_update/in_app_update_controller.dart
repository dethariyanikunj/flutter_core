import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/app_utils.dart';

class InAppUpdateController extends GetxController {
  void updateApp() {
    Get.back();
    try {
      final url = Uri.parse(AppConfig.iOSAppStoreLink);
      launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
