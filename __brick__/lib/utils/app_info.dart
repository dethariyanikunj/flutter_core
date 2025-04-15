import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  String getDeviceType() {
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    if (Platform.isLinux) return 'Linux';
    if (Platform.isMacOS) return 'macOS';
    if (Platform.isWindows) return 'Windows';
    if (kIsWeb) return 'Web';
    return 'Unknown';
  }

  Future<String> getDeviceName() async {
    final deviceInfo = DeviceInfoPlugin();
    String deviceName = '';
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceName = '${androidInfo.brand} ${androidInfo.model}';
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.name;
    }
    return deviceName;
  }

  Future<String> getDeviceVersion() async {
    final deviceInfo = DeviceInfoPlugin();
    String deviceVersion = '';
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceVersion = androidInfo.version.release;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceVersion = iosInfo.systemVersion;
    }
    return deviceVersion;
  }

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<String> getAppVersionCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  Future<String> getAppBundleId() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }
}
