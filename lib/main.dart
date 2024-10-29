import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:com.zat.linedup/globals.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

import 'Service/NotificationsService/NotificationsService.dart';
import 'app.dart';
import 'firebase_options.dart';
@pragma("vm:entry-point")
Future<void> backgroundMessage(RemoteMessage message)async{
  await Firebase.initializeApp();
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(backgroundMessage);

  final PlatformWebViewControllerCreationParams params;
  if (WebViewPlatform.instance is WebKitWebViewPlatform) {
    params = WebKitWebViewControllerCreationParams(
      allowsInlineMediaPlayback: true,
      mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
    );
  } else {
    params = const PlatformWebViewControllerCreationParams();
  }
  NotificationService().requestPermission();
  NotificationService().initFirebase();
  NotificationService().foregroundMessage();

  // NotificationService().isTokenExpire();
  NotificationService().getDeviceToken().then((value) {
    token = value;
    print("Device Token :$token");

  });
  final WebViewController controller =
  WebViewController.fromPlatformCreationParams(params);
// ···
  if (controller.platform is AndroidWebViewController) {
    AndroidWebViewController.enableDebugging(true);
    (controller.platform as AndroidWebViewController)
        .setMediaPlaybackRequiresUserGesture(false);
  }
  WebViewPlatform.instance;



  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}
