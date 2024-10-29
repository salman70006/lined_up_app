import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void localNotificationInit(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
    AndroidInitializationSettings("@mipmap/launcher_icon.png");
    var iosInitializationSettings = DarwinInitializationSettings();
    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {});
  }

  void initFirebase() {
    FirebaseMessaging.onMessage.listen((event) {
      if (kDebugMode) {
        print("MessageTitle: ${event.notification?.title.toString()}");
        print("MessageBody: ${event.notification?.body.toString()}");
      }
      if(Platform.isIOS){
        foregroundMessage();
      }
      showNotification(event);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(10000).toString(),
      "High Priority",
    );

    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(channel.id, channel.name,
        importance: Importance.high,
        priority: Priority.high,
        ticker: "ticker",
        channelDescription: "your channel Description",
        icon: "@mipmap/launcher_icon"
    );
    DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification?.title.toString(),
          message.notification?.body,
          notificationDetails);
    });
  }

  void requestPermission() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("userGrantedPermission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("userGrantedProvisionalPermission");
    } else {
      print("userDeniedPermission");
    }
  }

  Future<String> getDeviceToken() async {
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    return deviceToken!;
  }

  isTokenExpire() {
    firebaseMessaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }
  Future foregroundMessage()async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
    );
  }
}
