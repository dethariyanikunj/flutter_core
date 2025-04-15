import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:in_app_update/in_app_update.dart';

import '../api/api.dart';
import '../utils/app_utils.dart';
import 'ios_in_app_update_response.dart';
import 'show_in_app_update.dart';

class InAppUpdateUtils {
  static const bool _isForceUpdateAllowed = true;
  static const bool _immediateFullScreenUpdateOnly = true;
  static const String _countryCode = 'IN';

  // Ref. https://developer.android.com/guide/playcore/in-app-updates
  // TODO: Call checkForAppUpdate() at your related file where you want to show this message also add WidgetsBindingObserver like below commented code
  /*
  class _DashboardPageState extends State<DashboardPage> with WidgetsBindingObserver {
  @override
  void initState() {
  super.initState();
  WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
  WidgetsBinding.instance.removeObserver(this);
  super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
  if (state == AppLifecycleState.resumed) {
      checkForAppUpdate();
  }
  }*/
  static Future<void> checkForAppUpdate() async {
    if (kReleaseMode) {
      if (Platform.isAndroid) {
        _checkForAndroid();
      } else if (Platform.isIOS) {
        _checkForIOS();
      }
    }
  }

  static void _checkForAndroid() {
    try {
      InAppUpdate.checkForUpdate().then(
            (updateInfo) {
          if (updateInfo.updateAvailability ==
              UpdateAvailability.updateAvailable) {
            debugPrint(
              'Full Screen Update Allowed: ${updateInfo
                  .immediateUpdateAllowed}',
            );
            if (_immediateFullScreenUpdateOnly) {
              // Perform immediate update
              InAppUpdate.performImmediateUpdate().then(
                    (appUpdateResult) {
                  if (appUpdateResult == AppUpdateResult.success) {
                    debugPrint('successfully updated!');
                  } else if (appUpdateResult ==
                      AppUpdateResult.inAppUpdateFailed) {
                    debugPrint('failed to update!');
                    if (_isForceUpdateAllowed) {
                      checkForAppUpdate();
                    }
                  } else if (appUpdateResult ==
                      AppUpdateResult.userDeniedUpdate) {
                    debugPrint('user denied to update!');
                    if (_isForceUpdateAllowed) {
                      checkForAppUpdate();
                    }
                  }
                },
              );
            } else if (updateInfo.flexibleUpdateAllowed) {
              // Perform flexible update
              InAppUpdate.startFlexibleUpdate().then(
                    (appUpdateResult) {
                  if (appUpdateResult == AppUpdateResult.success) {
                    debugPrint('successfully updated!');
                    InAppUpdate.completeFlexibleUpdate();
                  } else if (appUpdateResult ==
                      AppUpdateResult.inAppUpdateFailed) {
                    debugPrint('failed to update!');
                    if (_isForceUpdateAllowed) {
                      checkForAppUpdate();
                    }
                  } else if (appUpdateResult ==
                      AppUpdateResult.userDeniedUpdate) {
                    debugPrint('user denied to update!');
                    if (_isForceUpdateAllowed) {
                      checkForAppUpdate();
                    }
                  }
                },
              );
            }
          }
        },
      );
    } on PlatformException catch (error) {
      debugPrint('$error');
    } on FormatException catch (error) {
      debugPrint('$error');
    } catch (error) {
      debugPrint('$error');
    }
  }

  static Future _checkForIOS() async {
    // e.g. https://itunes.apple.com/lookup?bundleId={ID}&country=IN
    final appInfo = AppInfo();
    final bundleId = await appInfo.getAppBundleId();
    final response = await ApiServiceConfig.iTunesApiService
        .getItunesRequest<IosInAppUpdateResponse>(
      ApiEndpoints.iTunesLookup,
      queryParams: {
        'bundleId': bundleId,
        'country': _countryCode,
      },
      fromJson: (data) => IosInAppUpdateResponse.fromJson(data),
    );
    if (response.isSuccess) {
      if (response.data?.results != null &&
          response.data!.results!.isNotEmpty) {
        final appStoreVersion = response.data!.results![0].version;
        if (appStoreVersion != null && appStoreVersion
            .trim()
            .isNotEmpty) {
          final splitAppStoreVersion = appStoreVersion.split('.');
          int? appStoreMajor, appStoreMinor, appStorePatch;
          int? currentAppMajor, currentAppMinor, currentAppPatch;
          if (splitAppStoreVersion.length == 3) {
            appStoreMajor = int.tryParse(splitAppStoreVersion[0]);
            appStoreMinor = int.tryParse(splitAppStoreVersion[1]);
            appStorePatch = int.tryParse(splitAppStoreVersion[2]);
          }
          if (appStoreMajor != null &&
              appStoreMinor != null &&
              appStorePatch != null) {
            final currentAppVersion = await appInfo.getAppVersion();
            if (currentAppVersion
                .trim()
                .isNotEmpty) {
              final splitCurrentAppVersion = currentAppVersion.split('.');
              if (splitCurrentAppVersion.length == 3) {
                currentAppMajor = int.tryParse(splitCurrentAppVersion[0]);
                currentAppMinor = int.tryParse(splitCurrentAppVersion[1]);
                currentAppPatch = int.tryParse(splitCurrentAppVersion[2]);
                if (currentAppMajor != null &&
                    currentAppMinor != null &&
                    currentAppPatch != null) {
                  // compare major / minor / patch versions
                  if (appStoreMajor > currentAppMajor) {
                    _openInAppUpdateBottomSheetForIOS();
                  } else if (appStoreMinor > currentAppMinor) {
                    _openInAppUpdateBottomSheetForIOS();
                  } else if (appStorePatch > currentAppPatch) {
                    _openInAppUpdateBottomSheetForIOS();
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  static void _openInAppUpdateBottomSheetForIOS() {
    ShowInAppUpdate().showBottomSheet();
  }
}
