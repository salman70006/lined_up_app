import UIKit
import Flutter
import FirebaseCore
import GoogleMaps
import flutter_local_notifications
@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  FirebaseApp.configure()
    GMSServices.provideAPIKey("AIzaSyDSO8hzA8ugD7nOmA-5LKMvmz_6FC47DRY")
     FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
        GeneratedPluginRegistrant.register(with: registry)
      }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
 if #available(iOS 10.0, *) {
   UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
 }
}