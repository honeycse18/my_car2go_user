import 'dart:convert';
import 'dart:developer';

import 'package:car2gouser/utils/app_singleton.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
      AppSingleton.instance.flutterLocalNotificationsPlugin;

  static Future<bool?> initialize() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/notify');

    var initializationSettingsiOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestProvisionalPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    InitializationSettings initializationSettings = InitializationSettings(
        // android: AndroidInitializationSettings('notification'));
        android: initializationSettingsAndroid,
        iOS: initializationSettingsiOS);
    return await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveBackgroundNotificationResponse:
            _onForegroundNotificationTap,
        onDidReceiveNotificationResponse: _onBackgroundNotificationTap);
  }

  static void _onForegroundNotificationTap(
          NotificationResponse notificationResponse) =>
      _onNotificationTap(notificationResponse);

  static void _onBackgroundNotificationTap(
          NotificationResponse notificationResponse) =>
      _onNotificationTap(notificationResponse);

  static void _onNotificationTap(NotificationResponse notificationResponse) {
    log(notificationResponse.payload.toString());
    if (notificationResponse.payload == null) {
      return;
    }
    try {
      final payloadAsMap = jsonDecode(notificationResponse.payload!);
      if (payloadAsMap is! Map) {
        return;
      }
      // if(payloadAsMap['type'] == 'ride_created'){
      //   Get.toNamed(AppPageNames.acceptedRequestScreen, arguments: [payloadAsMap['data']]);
      // };
    } catch (e) {
      return;
    }
  }
}
