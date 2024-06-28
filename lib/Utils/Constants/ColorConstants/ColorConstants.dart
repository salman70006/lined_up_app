import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorConstants {
  static const appPrimaryColor = Color(0xff0DC81D);
  static const textGreyColor = Color(0xff787878);
  static const blackColor = Color(0xff323232);
  static const whiteColor = Color(0xffFFFFFF);
  static const redColor = Color(0xffF75555);
  static const dotsGreyColor = Color(0xffD9D9D9);
  static const socialButtonBorderColor = Color(0xffE8ECF4);
  static const textFieldBorderColor = Color(0xffF7F8F9);
  static const hintTextColor = Color(0xff8391A1);
  static const forgotPasswordColor = Color(0xff6A707C);
  static const tabUnselectedColor = Color(0xffA3A3A3);
  static const doesNotHaveAccountColor = Color(0xff1E232C);
  static const barSearchFillColor = Color(0xffF4F4F4);
  static const scaffoldColor = Color(0xffE3E3E3);
  static const dailyPromotionContainerColor = Color(0xffF6F6F6);
  static const aboutBlackColor = Color(0xff000000);
  static const daysTextColor = Color(0xff94A3B8);
  static const dayBoxColor = Color(0xffE8F3EC);
  static const daysDotColor = Color(0xff1AA54A);
  static const notAvailableColor = Color(0xffD6D6D6);
  static const eventsContainerColor = Color(0xffF2F2F2);
  static const memberCountBoxColor = Color(0xff1274AC1A);
  static const cancelButtonColor = Color(0xffE6ECFB);
  static const whiteOpacity = Color(0xff818181);
  static const profileNameColor = Color(0xff242760);
  static const infoColor = Color(0xff424242);
  static const profileFieldsBorderColor = Color(0xff544C4C24);
  static const notificationTextColor = Color(0xff616161);
  static const supportFieldsColor = Color(0xffF7F8F9);
  static const supportFieldsBorderColor = Color(0xffE8ECF4);

  // Gradient Colors
  static List<Color> expressReservationColor = [
    const Color(0xff0DC81E),
    const Color(0xff000000).withOpacity(0.6)
  ];
  static List<Color> expressReservationButtonColor = [const Color(0xff0DC81E), const Color(0xff000000)];
  static List<Color> eventDateGradient = [const Color(0xff009E19), const Color(0xff5CCC6E)];
  static List<Color> reservationGradientWhiteColorContainer = [
    const Color(0xff818181).withOpacity(0.sp),
    const Color(0xffFFFFFF),
  ];
  static List<Color> simpleReservationGradient = [const Color(0xff524E4E), blackColor.withOpacity(0.sp)];
  static List<Color> reservationButtonColor = [
    const Color(0xff9F9F9F),
    const Color(0xff524E4E),
  ];
  static List<Color> simpleTicketColor = [
    const Color(0xff524E4E),
    const Color(0xff9F9F9F),
  ];
  static List<Color> eventTicketColor = [
    const Color(0xffFFFFFF),
    const Color(0xffD6D6D6),
  ];
}
