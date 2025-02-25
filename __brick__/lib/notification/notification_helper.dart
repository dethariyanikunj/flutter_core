import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as notification;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import '../api/api.dart';
import '../api/responses/api_success_response.dart';
import '../utils/app_utils.dart';
import './notification_redirection_info.dart';

late NotificationAppLaunchDetails notificationLaunch;
final FlutterLocalNotificationsPlugin notificationPlugin =
    FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//https://itnext.io/local-notifications-in-flutter-6136235e1b51
class NotificationHelper {
  static NotificationRedirectionInfo? notificationRedirectionInfo;
  static String? fcmToken;
  static StreamSubscription<String>? _firebaseMessagingTokenStreamSubscription;

  // same as Android > manifest > meta data > default_notification_icon
  static const String _notificationIconName = 'ic_notification';

  // same as Android > manifest > meta data > default_notification_channel_id
  static const String _fcmNotificationChannelId = 'MakeMyMembershipChannel';
  static const String _fcmNotificationChannelName = 'MakeMyMembership';
  static const String _fcmNotificationChannelDesc =
      'You will receive Notifications of App here';

  static Future<String?> getFirebaseDeviceToken() async {
    try {
      fcmToken = await FirebaseMessaging.instance.getToken();
      debugPrint('Firebase device token: $fcmToken');
    } catch (error) {
      debugPrint('$error');
    }
    return fcmToken;
  }

  // For Future usage:
  static void observeFirebaseDeviceTokenChange() {
    if (_firebaseMessagingTokenStreamSubscription != null) {
      _firebaseMessagingTokenStreamSubscription!.cancel();
    }
    _firebaseMessagingTokenStreamSubscription =
        FirebaseMessaging.instance.onTokenRefresh.listen(
      (event) {
        fcmToken = event;
        debugPrint('OnTokenChange: $fcmToken');
        updateFcmToken();
      },
    );
  }

  /// Update FCM Token
  static Future updateFcmToken() async {
    await ApiServiceConfig.apiService.postRequest<ApiSuccessResponse>(
      ApiEndpoints.updateFcmToken,
      body: {
        'fcm_token': fcmToken,
      },
      fromJson: (data) => ApiSuccessResponse.fromJson(data),
    );
  }

  static Future<bool?> getNotificationPermission() async {
    if (await Permission.notification.request().isGranted) {
      return true;
    } else if (await Permission.notification.request().isPermanentlyDenied) {
      return null;
    } else if (await Permission.notification.request().isDenied) {
      return false;
    }
    return false;
  }

  static Future<void> initNotifications(
    notification.FlutterLocalNotificationsPlugin notificationPlugin,
  ) async {
    // Initially notification redirection info set to NULL to restrict redirection
    notificationRedirectionInfo = null;
    // ------
    const initializationSettingsAndroid =
        notification.AndroidInitializationSettings(_notificationIconName);
    const initializationSettingsIOS =
        notification.DarwinInitializationSettings();
    const initializationSettings = notification.InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await notificationPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) =>
          _onNotificationClicked(response.payload),
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );
    await notificationPlugin
        .resolvePlatformSpecificImplementation<
            notification.IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    listenFCM();
    debugPrint('Notifications initialised successfully');
  }

  static Future<void> _createFCMChannel() async {
    const AndroidNotificationChannel fcmChannel = AndroidNotificationChannel(
      _fcmNotificationChannelId,
      _fcmNotificationChannelName,
      description: _fcmNotificationChannelDesc,
      importance: Importance.max,
      enableLights: true,
      enableVibration: false,
      playSound: true,
      showBadge: true,
    );
    await notificationPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(fcmChannel);
  }

  static Future<void> listenFCM() async {
    await _createFCMChannel();
    FirebaseMessaging.onBackgroundMessage(fcmBackgroundMessageHandler);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      _onFCMNotificationClicked(message);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // ---- On Foreground ----
      debugPrint(
        'onMessage invoked:: ${message.notification?.title}, ${message.notification?.body}',
      );
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        int notificationId = Random().nextInt(50000);
        if (await _isNotificationEnabled()) {
          //by default IOS shows notification itself
          if (!Platform.isIOS) {
            notificationPlugin.show(
              notificationId,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  _fcmNotificationChannelId,
                  _fcmNotificationChannelName,
                  channelDescription: _fcmNotificationChannelDesc,
                  visibility: NotificationVisibility.public,
                  enableVibration: false,
                  enableLights: true,
                  playSound: true,
                  channelShowBadge: true,
                  priority: Priority.high,
                  importance: Importance.high,
                  tag: notificationId.toString(),
                  color: AppColors.primary,
                ),
                iOS: const DarwinNotificationDetails(
                  presentBadge: true,
                  presentSound: true,
                ),
              ),
              payload: jsonEncode(message.data),
            );
          }
        }
      }
    });
  }

  static Future<bool> _isNotificationEnabled() async {
    return true;
  }

  static void _onNotificationClicked(String? payload) {
    // This method being called when app is in foreground and notification came ++
    // notification clicked with app foreground or in background (Not killed)
    debugPrint('Notification Redirection: onDidReceiveNotificationResponse');
    _handleNotificationRedirection(payload);
  }

  // Due to unable to receive notification from background in release version of app : https://stackoverflow.com/a/74623355/28546545
  @pragma('vm:entry-point')
  static Future<void> fcmBackgroundMessageHandler(RemoteMessage message) async {
    debugPrint(
      'fcmBackgroundMessageHandler invoked:: ${message.notification?.title}, ${message.notification?.body}, ${message.data}',
    );
  }

  static void _onFCMNotificationClicked(RemoteMessage message) {
    // This method being called when app is in background (Not Killed)
    // and notification came ++ notification clicked in background (Not killed)
    debugPrint('Notification Redirection - onMessageOpenedApp');
    _handleNotificationRedirection(jsonEncode(message.data));
  }

  @pragma('vm:entry-point')
  static void onDidReceiveBackgroundNotificationResponse(
    notification.NotificationResponse response,
  ) {
    debugPrint(
      'Notification Redirection: onDidReceiveBackgroundNotificationResponse',
    );
    _handleNotificationRedirection(response.payload);
  }

  static Future<void> _handleNotificationRedirection(String? payload) async {
    // Todo: change route / logic based on your requirement
    const routeToRedirect = AppRoutes.splashPage;
    if (navigatorKey.currentContext != null) {
      bool isRouteAlreadyOpened = false;
      Navigator.popUntil(
        navigatorKey.currentContext!,
        (route) {
          if (route.settings.name == routeToRedirect) {
            isRouteAlreadyOpened = true;
          }
          return true;
        },
      );
      if (!isRouteAlreadyOpened) {
        navigatorKey.currentState?.pushNamed(
          routeToRedirect,
          arguments: {},
        );
      }
    }
  }

  static Future checkForInitialNotification() async {
    await FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        debugPrint('Notification Redirection: from initial message:');
        // From this function, Unable to redirect to any screen
        // navigator key initialised -> navigatorKey.currentContext might be null
        // To handle this created one flag that we can handle in launcher screens
        // to redirect in specific screen (launcher screen -> either splash or other as per app need)
        notificationRedirectionInfo = NotificationRedirectionInfo(
          remoteMessage: message,
          extraData: {
            // Any extra data to handle navigation goes here!
          },
        );
      }
    });
  }

  static Future<void> clearAllNotifications() async {
    await notificationPlugin.cancelAll();
  }
}
