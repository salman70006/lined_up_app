import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linedup_app/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:linedup_app/Utils/Constants/ColorConstants/ColorConstants.dart';

class PromotionContainer extends StatelessWidget {
  Color? containerColor,textColor;
  String? title,detail;
  double? borderRadius,height,width,padding,margin,letterSpacing,fontSize;
  List<Color>? colors;
  TextStyle? style,detailStyle;
  AlignmentGeometry? begin,end;
   PromotionContainer({
    this.containerColor,
     this.textColor,
     this.title,
     this.borderRadius,
     this.colors,
     this.style,
     this.height,
     this.width,
     this.begin,
     this.end,
     this.detail,
     this.detailStyle,
     this.padding,
     this.letterSpacing,
     this.fontSize
});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ??17.sp,
      width: width ?? 70.sp,
      padding: EdgeInsets.all(padding??2.sp),
      margin: EdgeInsets.only(top: margin??5.sp),
      decoration: containerColor!=null? BoxDecoration(
        borderRadius:BorderRadius.circular(borderRadius??15.sp),
        color: containerColor,
      ):BoxDecoration(
        borderRadius:BorderRadius.circular(borderRadius??15.sp),
        gradient: LinearGradient(
            begin: begin!,
            end: end!,
            colors: colors!),
      ),
      child: Center(
        child: Text(
          title??"",
          style: style?? StaticTextStyle().regular.copyWith(
            fontSize: fontSize?? 10.sp,
            fontFamily: arimoBold,
            letterSpacing: letterSpacing??1.sp,
            color: textColor??ColorConstants.whiteColor
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
