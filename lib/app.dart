import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linedup_app/Providers/AllBarsProvider/AllBarsProvider.dart';
import 'package:linedup_app/Providers/AllFavouritesProvider/AllFavouritesProvider.dart';
import 'package:linedup_app/Providers/AllPromotionsProvider/AllPromotionsProvider.dart';
import 'package:linedup_app/Providers/AllReservationProvider/AllReservationProvider.dart';
import 'package:linedup_app/Providers/AllUsersProvider/AllUsersProvider.dart';
import 'package:linedup_app/Providers/BarDetailProvider/BarDetailProvider.dart';
import 'package:linedup_app/Providers/BarEventDetailProvider/BarEventDetailProvider.dart';
import 'package:linedup_app/Providers/BeachBarDetailProvider/BeachBarDetailProvider.dart';
import 'package:linedup_app/Providers/ForgotPasswordPrvoider/ForgotPasswordProvider.dart';
import 'package:linedup_app/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:linedup_app/Providers/LoginProvider/LoginProvider.dart';
import 'package:linedup_app/Providers/ReservationsDetailProvider/ReservationDetailProvider.dart';
import 'package:linedup_app/Providers/ResetPasswordProvider/ResetpasswordProvider.dart';
import 'package:linedup_app/Providers/TransferTicketProvider/TransferTicketProvider.dart';
import 'package:linedup_app/Providers/UserProfileProvider/UserProfileProvider.dart';
import 'package:linedup_app/Providers/UserRegistrationProvider/UserRegistrationProvider.dart';
import 'package:linedup_app/Providers/privacyPolicyProvider/PrivacyPolicyProvider.dart';
import 'package:linedup_app/Utils/Constants/RouteConstants/RouteConstants.dart';
import 'package:linedup_app/globals.dart';
import 'package:provider/provider.dart';
import 'Components/Routes/Routes.dart';
import 'Providers/HelpProvider/HelpProvider.dart';


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
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: RouteConstants.initialRoute,
            onGenerateRoute: RouteGenerator.generateRoute,
          ),

        );
      },
    );
  }
}
