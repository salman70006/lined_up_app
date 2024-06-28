import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAFbViWtBgXIXItN4Ei0O340e0QqlTdPBk",
          appId: "1:415680926280:android:a8df82f8e9d3ed1950be7d",
          messagingSenderId: "415680926280",
          projectId: "linedup-eade0")
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}
