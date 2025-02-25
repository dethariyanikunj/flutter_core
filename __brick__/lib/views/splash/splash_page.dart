import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_utils.dart';
import './splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: Center(
        child: Obx(
          () => Text(
            controller.appName.value,
          ),
        ),
      ),
    );
  }
}
