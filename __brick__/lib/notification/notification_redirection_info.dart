import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationRedirectionInfo {
  const NotificationRedirectionInfo({
    required this.remoteMessage,
    required this.extraData,
  });

  final RemoteMessage? remoteMessage;
  final dynamic extraData;
}
