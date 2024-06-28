import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/Constants/ColorConstants/ColorConstants.dart';

String englishBold = "englishBold";
String englishRegular = "englishRegular";
String englishMedium = "englishMedium";
String urbanBold = "urbanBold";
String urbanMedium ="urbanMedium";
String urbanRegular ="urbanRegular";
String abelBold ="abelBold";
String arimoBold ="arimoBold";
String englishItalic ="englishItalic";

class StaticTextStyle{

  var regular = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      fontFamily: englishRegular,
      color: ColorConstants.whiteColor
  );
  var boldTextStyle = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    fontFamily: englishBold,
    color: ColorConstants.whiteColor,
  );

}