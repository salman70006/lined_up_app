import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:com.zat.linedup/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:com.zat.linedup/Utils/Constants/ColorConstants/ColorConstants.dart';

import '../Extentions/PaddingExtentions.dart';

class ShowMessage{

  showMessage(BuildContext context,String message,Color color){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.all(8.sp),
        margin: EdgeInsets.all(PaddingExtensions.screenOverAllPadding),
        content: Center(
          child: Text(
            message.toString(),
            style: StaticTextStyle().regular.copyWith(
              fontSize: 14.sp,
              color: ColorConstants.whiteColor,
            ),
          ),
        ),
        backgroundColor:  color,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}