import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linedup_app/Utils/Constants/ColorConstants/ColorConstants.dart';

class BackButtonWidget extends StatelessWidget {
  Color? borderColor, containerColor, iconColor;
  Widget? imageWidget;
  double? height, width, iconSize,leftPadding,topPadding,borderRadius;
  IconData? icon;
  final VoidCallback? onPress;
  BackButtonWidget({this.borderColor,
    this.containerColor,
    this.imageWidget,
    this.iconColor,
    this.iconSize,
    this.icon,
    this.height,
    this.width,
  this.onPress,
    this.topPadding,
    this.leftPadding,
    this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onPress,
      child: Container(
        height: height ?? 41.sp,
        width: width ?? 41.sp,
        padding: EdgeInsets.only(left: leftPadding?? 5.sp,top: topPadding??2.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius??12.sp),
          color: containerColor ?? ColorConstants.whiteColor,
          border: Border.all(
              color: borderColor ?? ColorConstants.socialButtonBorderColor,
              width: 1.sp),
        ),
        child: Align(
            alignment: Alignment.center,
            child: icon!=null? Icon(icon, color: iconColor?? ColorConstants.blackColor,size: iconSize??15.sp,):
       imageWidget ),
      ),
    );
  }
}
