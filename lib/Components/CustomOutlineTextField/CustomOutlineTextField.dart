
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/Constants/ColorConstants/ColorConstants.dart';
import '../Extentions/PaddingExtentions.dart';
import '../StaticTextStyle/StaticTextStyle.dart';

class CustomOutlineTextFormField extends StatelessWidget {
  TextEditingController? controller;
  FocusNode? focusNode;
  TextInputType? keyboardType;
  TextStyle? style,hintStyle;
  bool? readOnly , obscureText,filled;
  String? obscuringCharacter,hintText;
  String? Function(String?)? validator;
  void Function(String)? onFieldSubmitted;
  void Function(String)? onChanged;
  double? borderRadius,borderWidth,fontSize;
  EdgeInsetsGeometry? contentPadding;
  Color? borderSideColor,filledColor,cursorColor;
  Widget? suffixIcon;
  Widget? prefixIcon;
  TextInputAction? textInputAction;
  int? maxLines;
   CustomOutlineTextFormField({super.key,
  this.controller,
    this.focusNode,
    this.keyboardType,
    this.style,
    this.obscureText=false,
    this.obscuringCharacter,
    this.onChanged,
    this.readOnly=false,
     this.onFieldSubmitted,
    this.validator,
     this.borderRadius,
     this.fontSize,
     this.borderWidth,
     this.borderSideColor,
     this.prefixIcon,
     this.suffixIcon,
     this.hintStyle,
     this.hintText,
     this.filledColor,
     this.filled=false,
     this.cursorColor,
     this.textInputAction,
     this.maxLines,
     this.contentPadding
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      maxLines: maxLines??1,
      textInputAction: textInputAction??TextInputAction.next,
      keyboardType: keyboardType??TextInputType.text,
      cursorColor: cursorColor??ColorConstants.whiteColor,
      readOnly: readOnly??false,
      style: style??TextStyle(
          color: ColorConstants.blackColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          fontFamily: englishMedium
      ),
      obscureText: obscureText!,
      obscuringCharacter: obscuringCharacter??"*",
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      decoration: InputDecoration(
        fillColor: filledColor,
        filled: filled,
        hintText:hintText,
        hintStyle: hintStyle??TextStyle(
          color: ColorConstants.hintTextColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          fontFamily: englishMedium
        ),
        contentPadding:contentPadding?? EdgeInsets.all(PaddingExtensions.screenOverAllPadding),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius??8.sp),
          borderSide: BorderSide(color:borderSideColor??ColorConstants.textFieldBorderColor,width: 1.sp),
        ),
        focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius??8.sp),
          borderSide: BorderSide(color:borderSideColor??ColorConstants.textFieldBorderColor,width: 1.sp),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius??8.sp),
          borderSide: BorderSide(color:borderSideColor??ColorConstants.textFieldBorderColor,width: 1.sp),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius??8.sp),
          borderSide: BorderSide(color:borderSideColor??ColorConstants.redColor),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
