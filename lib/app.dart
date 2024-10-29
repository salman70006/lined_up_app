import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:com.zat.linedup/Providers/AllBarsProvider/AllBarsProvider.dart';
import 'package:com.zat.linedup/Providers/AllFavouritesProvider/AllFavouritesProvider.dart';
import 'package:com.zat.linedup/Providers/AllPromotionsProvider/AllPromotionsProvider.dart';
import 'package:com.zat.linedup/Providers/AllReservationProvider/AllReservationProvider.dart';
import 'package:com.zat.linedup/Providers/AllUsersProvider/AllUsersProvider.dart';
import 'package:com.zat.linedup/Providers/BarDetailProvider/BarDetailProvider.dart';
import 'package:com.zat.linedup/Providers/BarEventDetailProvider/BarEventDetailProvider.dart';
import 'package:com.zat.linedup/Providers/BeachBarDetailProvider/BeachBarDetailProvider.dart';
import 'package:com.zat.linedup/Providers/EditProfileProvider/EditProfileProvider.dart';
import 'package:com.zat.linedup/Providers/ForgotPasswordPrvoider/ForgotPasswordProvider.dart';
import 'package:com.zat.linedup/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:com.zat.linedup/Providers/LoginProvider/LoginProvider.dart';
import 'package:com.zat.linedup/Providers/NotificationsProvider/NotificationsProvider.dart';
import 'package:com.zat.linedup/Providers/ReservationsDetailProvider/ReservationDetailProvider.dart';
import 'package:com.zat.linedup/Providers/ResetPasswordProvider/ResetpasswordProvider.dart';
import 'package:com.zat.linedup/Providers/TransferTicketProvider/TransferTicketProvider.dart';
import 'package:com.zat.linedup/Providers/UserProfileProvider/UserProfileProvider.dart';
import 'package:com.zat.linedup/Providers/UserRegistrationProvider/UserRegistrationProvider.dart';
import 'package:com.zat.linedup/Providers/privacyPolicyProvider/PrivacyPolicyProvider.dart';
import 'package:com.zat.linedup/Utils/Constants/RouteConstants/RouteConstants.dart';
import 'package:com.zat.linedup/globals.dart';
import 'package:provider/provider.dart';
import 'Components/Routes/Routes.dart';
import 'Providers/HelpProvider/HelpProvider.dart';
import 'Providers/SocialLoginsAuthProvider/SocailLoginsAuthProvider.dart';


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token;
  getFcmToken()async{
     token = await FirebaseMessaging.instance.getToken().then((value) {
       fcmToken = value;
       print("Device token:$fcmToken");

     });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFcmToken();
  }
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => UserRegistrationProvider()),
            ChangeNotifierProvider(create: (context) => LoginProvider()),
            ChangeNotifierProvider(create: (context) => ResetPasswordProvider()),
            ChangeNotifierProvider(create: (context) => BeachBarDetailProvider()),
            ChangeNotifierProvider(create: (context) => LoadingProvider()),
            ChangeNotifierProvider(create: (context) => AllBarsProvider()),
            ChangeNotifierProvider(create: (context) => AllPromotionsProvider()),
            ChangeNotifierProvider(create: (context) => AllFavouritesProvider()),
            ChangeNotifierProvider(create: (context) => EventDetailProvider()),
            ChangeNotifierProvider(create: (context) => PrivacyPolicyAndTcProvider()),
            ChangeNotifierProvider(create: (context) => HelpProvider()),
            ChangeNotifierProvider(create: (context) => AllReservationProvider()),
            ChangeNotifierProvider(create: (context) => ReservationDetailProvider()),
            ChangeNotifierProvider(create: (context) => AllUsersProvider()),
            ChangeNotifierProvider(create: (context) => UserProfileProvider()),
            ChangeNotifierProvider(create: (context) => TransferTicketProvider()),
            ChangeNotifierProvider(create: (context) => ForgotPasswordProvider()),
            ChangeNotifierProvider(create: (context) => BarDetailProvider()),
            ChangeNotifierProvider(create: (context) => EditProfileProvider()),
            ChangeNotifierProvider(create: (context) => NotificationsProvider()),
            ChangeNotifierProvider(create: (context) => SocialAuthProvider(firebaseAuth: FirebaseAuth.instance, googleSignIn: GoogleSignIn.standard())),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              pageTransitionsTheme: PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
                }
              )
            ),
            initialRoute: RouteConstants.initialRoute,
            onGenerateRoute: RouteGenerator.generateRoute,
          ),

        );
      },
    );
  }
}
