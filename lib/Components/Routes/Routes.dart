import 'package:flutter/material.dart';
import 'package:com.zat.linedup/UI/AppBottomBar/AppBottomBar.dart';
import 'package:com.zat.linedup/UI/AppPrivacyPolicyPage/AppPricacyPolicyPage.dart';
import 'package:com.zat.linedup/UI/AppTermsAndConditions/AppTermsAndConditions.dart';
import 'package:com.zat.linedup/UI/AuthPages/ForgotPassword/ForgotPassword.dart';
import 'package:com.zat.linedup/UI/AuthPages/LoginPage/LoginPage.dart';
import 'package:com.zat.linedup/UI/AuthPages/OtpVarification/OTPVerification.dart';
import 'package:com.zat.linedup/UI/AuthPages/PasswordChangesSuccessPage/PasswordChangeSuccessPage.dart';
import 'package:com.zat.linedup/UI/AuthPages/ResetPasswordPage/ResetPasswordPage.dart';
import 'package:com.zat.linedup/UI/AuthPages/SignupPage/SignupPage.dart';
import 'package:com.zat.linedup/UI/BarDetailPage/BarDetailPage.dart';
import 'package:com.zat.linedup/UI/EditProfilePage/EditProfilePage.dart';
import 'package:com.zat.linedup/UI/EventDetailScreen/EventDetailScreen.dart';
import 'package:com.zat.linedup/UI/HelpAndSupportPage/HelpAndSupportPage.dart';
import 'package:com.zat.linedup/UI/MapPage/MapPage.dart';
import 'package:com.zat.linedup/UI/NotificationsPage/NotificationsPage.dart';
import 'package:com.zat.linedup/UI/OnBordingScreen/OnBoardingScreen.dart';
import 'package:com.zat.linedup/UI/PaymentMethodsPage/PaymentMethodsPage.dart';
import 'package:com.zat.linedup/UI/PromotionsPage/PromotionsPage.dart';
import 'package:com.zat.linedup/UI/ReservationDetailPage/ReservationDetailPage.dart';
import 'package:com.zat.linedup/UI/ReservationSearchPage/ReservationsSearchPage.dart';
import 'package:com.zat.linedup/UI/TransferTicketView/TransferTicketView.dart';
import 'package:com.zat.linedup/UI/ViewTicketPage/ViewTicketPage.dart';
import 'package:com.zat.linedup/UI/WishListSearchedResultPage/WishListSearchedResultPage.dart';
import 'package:com.zat.linedup/Utils/Constants/RouteConstants/RouteConstants.dart';
import 'package:page_transition/page_transition.dart';

import '../../UI/SearchResultPage/SearchResultPage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    const animationDuration = Duration(microseconds: 300);

    final args = settings.arguments;

    switch (settings.name) {
      case RouteConstants.initialRoute:
        return PageTransition(
            child: const OnboardingScreen(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.loginPageRoute:
        return PageTransition(
            child:  LoginPage(
              fromLogout: args,
            ), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.signupPageRoute:
        return PageTransition(
            child: const SignupPage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.forgotPasswordPageRoute:
        return PageTransition(
            child: const ForgotPasswordPage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.otpVerification:
        return PageTransition(
            child:  OtpVerification(
              otp: args,
            ), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.createNewPasswordPage:
        return PageTransition(
            child:  ResetPasswordPage(
              userEmail: args,
            ), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.resetPasswordSuccessPage:
        return PageTransition(
            child:  PasswordChangeSuccessPage(),
            type: PageTransitionType.fade,
            duration: animationDuration);
      case RouteConstants.appBottomBarRoute:
        return PageTransition(
            child: AppBottomBarPage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.promotionsPageRoute:
        return PageTransition(
            child: PromotionsPage(
              barId: args as int,
              coverImage: args,
            ), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.eventPageRoute:
        return PageTransition(
            child: EventDetailScreen(
           data: args,
            ), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.barDetailPage:
        return PageTransition(
            child: BarDetailPage(barId: args,), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.paymentMethodsPageRoute:
        return PageTransition(
            child: PaymentMethodsPage(
              paymentUrl: args,
            ), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.reservationDetailPage:
        return PageTransition(
            child: ReservationDetailPage(

              detailId: args,
            ),
            type: PageTransitionType.fade,
            duration: animationDuration);
      case RouteConstants.viewTicketPage:
        return PageTransition(
            child: ViewTicketPage(
              ticketType: args,
            ),
            type: PageTransitionType.fade,
            duration: animationDuration);
      case RouteConstants.transferTicketPageRoute:
        return PageTransition(
            child: TransferTicketView(
              ticketId: args,
            ), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.editProfilePageRoute:
        return PageTransition(
            child: EditProfilePage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.notificationsPageRoute:
        return PageTransition(
            child: NotificationsPage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.helpAndSupportPageRoute:
        return PageTransition(
            child: HelpAndSupportPage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.appPrivacyPolicyPageRoute:
        return PageTransition(
            child: AppPrivacyPolicyPage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.appTermsAndConditions:
        return PageTransition(
            child: AppTermsAndConditions(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.mapPageRoute:
        return PageTransition(
            child: MapPage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.searchedResultsRoute:
        return PageTransition(
            child: SearchResultPage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.wishListSearchedResultPageRoute:
        return PageTransition(
            child: WishListSearchResultPage(), type: PageTransitionType.fade, duration: animationDuration);
      case RouteConstants.reservationSearchRoute:
        return PageTransition(
            child: ReservationsSearchPage(), type: PageTransitionType.fade, duration: animationDuration);

      default:
        return _errorRoute();
    }
    // If args is not of the correct type, return an error page.
    // You can also throw an exception while in development.
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('ERROR'),
      ),
    );
  });
}
