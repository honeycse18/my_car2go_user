import 'dart:convert';
import 'dart:developer';

import 'package:car2gouser/services/profile_service.dart';
import 'package:car2gouser/utils/app_pages.dart';
import 'package:car2gouser/utils/app_singleton.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/app_notification_service.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSingleton.instance.initialize();
  await Firebase.initializeApp();
  await LocalNotificationService.initialize();

  await Firebase.initializeApp();
  FirebaseMessaging.onMessage.listen(onForegroundHandler);
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const Car2GoApp());
}

Future<void> onForegroundHandler(RemoteMessage remoteMessage) async {
  log(remoteMessage.toMap().toString());
  try {
    await Helper.showNotification(
        title: remoteMessage.notification?.title ?? '',
        message: remoteMessage.notification?.body ?? '',
        payload: jsonEncode(remoteMessage.data));
  } catch (e) {
    await Helper.showNotification(
        title: remoteMessage.notification?.title ?? '',
        message: remoteMessage.notification?.body ?? '',
        payload: remoteMessage.data.toString());
  }
}

Future<void> backgroundHandler(RemoteMessage remoteMessage) async {
  log(remoteMessage.toMap().toString());
  try {
    await Helper.showNotification(
        title: remoteMessage.notification?.title ?? '',
        message: remoteMessage.notification?.body ?? '',
        payload: jsonEncode(remoteMessage.data));
  } catch (e) {
    await Helper.showNotification(
        title: remoteMessage.notification?.title ?? '',
        message: remoteMessage.notification?.body ?? '',
        payload: remoteMessage.data.toString());
  }
}

class Car2GoApp extends StatelessWidget {
  const Car2GoApp({Key? key}) : super(key: key);

  /*<-------- This widget is the root of this app.------->*/
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppLanguageTranslation.appTitleTransKey.toCurrentLanguage,
      getPages: AppPages.pages,
      unknownRoute: AppPages.unknownScreenPageRoute,
      initialRoute: AppPageNames.rootScreen,
      theme: AppThemeData.appThemeData,
    );
  }
}
