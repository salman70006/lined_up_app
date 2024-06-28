import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linedup_app/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:linedup_app/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:linedup_app/Utils/Constants/ColorConstants/ColorConstants.dart';

import '../../../Components/CustomAppButton/CustomAppButton.dart';
import '../../../Components/Extentions/PaddingExtentions.dart';
import '../../../Utils/Constants/RouteConstants/RouteConstants.dart';

class PasswordChangeSuccessPage extends StatefulWidget {

   PasswordChangeSuccessPage({super.key});

  @override
  State<PasswordChangeSuccessPage> createState() => _PasswordChangeSuccessPageState();
}

class _PasswordChangeSuccessPageState extends State<PasswordChangeSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: EdgeInsets.only(top: PaddingExtensions.screenTopPadding,left: PaddingExtensions.screenLeftSidePadding,right: PaddingExtensions.screenRightSidePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
                child: Column(
                  children: [
                    SvgPicture.asset(AssetConstants.successMark,height: 100.sp,width: 100.sp,),
                    Padding(
                      padding:  EdgeInsets.only(top: 30.sp,bottom: 20.sp),
                      child: Text(
                          "Password Changed!",
                        style: StaticTextStyle().boldTextStyle.copyWith(
                          fontSize: 26.sp,
                          color: ColorConstants.blackColor
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 150.sp,
                      child: Text(
                          "Your password has been changed successfully.",
                        style: StaticTextStyle().regular.copyWith(
                          fontSize: 15.sp,
                          color: ColorConstants.hintTextColor
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 30.sp),
                      child: CustomAppButton(
                        title: "Back to Login",
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp,
                        fontFamily: englishBold,
                        onPress: (){
                          Navigator.of(context)..pop()..pop()..pop()..pop();
                        },
                      ),
                    ),

                  ],
                )),
          ],
        ),
      ),
    );
  }
}
