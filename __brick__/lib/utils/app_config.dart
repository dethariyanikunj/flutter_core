import 'dart:ui';

class AppConfig {
  static const String appName = '{{app_name}}';
  static const int splashTimer = 2;
  // 10 digit and 1 for space between
  static const int mobileNoFieldLength = 11;
  static const int mobileFormatterLength = 5;
  static const int mobileOtpLength = 6;
  static const int resendOtpLength = 30;
  static const bool isRefreshTokenEnabled = false;
  static const bool isOtpPrefilledWithClipBoard = false;
  static Size figmaScreenSize = const Size(428, 926);
  // TODO: Replace app name and apple id here to redirect to app store
  static const String iOSAppStoreLink =
      'https://apps.apple.com/us/app/{{apple_app_name}}/id{{apple_app_id}}';
}
