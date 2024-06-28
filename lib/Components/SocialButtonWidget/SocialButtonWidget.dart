
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/Constants/ColorConstants/ColorConstants.dart';

class SocialButtonWidget extends StatelessWidget {
  void Function()? onPressed;
  Widget? iconWidget;
  String? title;
  Color? buttonColor,borderColor,textColor;
  double? width,height,radius;
  SocialButtonWidget({
    this.onPressed,
    this.title,
    this.buttonColor,
    this.iconWidget,
    this.width,
    this.height,
    this.radius,
    this.borderColor,
    this.textColor
});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressed,
        icon: Padding(
          padding:  EdgeInsets.only(left: 10.sp),
          child: iconWidget!,
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius??8.sp),
            side: BorderSide(color: borderColor??ColorConstants.socialButtonBorderColor)
          ),
          backgroundColor: buttonColor??ColorConstants.whiteColor,
          minimumSize: Size(width??100.sp, height??56.sp)
        ),
      label: Text(
        title??"",
      ),
    );
  }
}
