
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:com.zat.linedup/Components/CustomAppButton/CustomAppButton.dart';
import 'package:com.zat.linedup/Providers/SocialLoginsAuthProvider/SocailLoginsAuthProvider.dart';
import 'package:com.zat.linedup/SharedPrefrences/SharedPrefrences.dart';
import 'package:com.zat.linedup/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:com.zat.linedup/Utils/Constants/Key_Constants.dart';
import 'package:com.zat.linedup/Utils/Constants/RouteConstants/RouteConstants.dart';
import 'package:com.zat.linedup/globals.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Components/Extentions/PaddingExtentions.dart';
import '../../Components/StaticTextStyle/StaticTextStyle.dart';
import '../../Utils/Constants/AssetConstants/AssetConstants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController controller = PageController();
  int pageIndex=0;
  getToken()async{
    await SharedPreferencesService().getString(KeysConstants.accessToken).then((value){
      token = value;
      print("UserToken:$token");
      if(token!=null && token!.isNotEmpty){
        Navigator.of(context).pushNamedAndRemoveUntil(RouteConstants.appBottomBarRoute,(Route<dynamic> route) => false);
      }
    });
  }
  void onAddButtonTapped(int index) {

    // use this to animate to the page
    // or this to jump to it without animating
    controller.jumpToPage(index);
  }
  List onboardImages =[
    AssetConstants.onboardImage,
    AssetConstants.onboardImage,
    AssetConstants.onboardImage,
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.7,
            child: Column(
              children: [
                Container(
                    height: 250,
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    child: Center(child: SvgPicture.asset(AssetConstants.onboardImage,fit: BoxFit.cover,height: 230.sp,width: double.infinity,))),
                SizedBox(
                  height: 40.sp,
                ),
                Text(
                  "Why Wait?",
                  style: StaticTextStyle().boldTextStyle.copyWith(
                      color: ColorConstants.blackColor
                  ),
                ),
                Container(
                  width: 313.sp,
                  child: Text(
                    "With LinedUp, you can reserve your spot in line days before the event begins. Waiting in lines is now a thing of the past, enjoy getting into events faster than ever when using LinedUp!",
                    style: StaticTextStyle().regular.copyWith(
                        color: ColorConstants.blackColor,
                        height: 1.9.sp
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // SmoothPageIndicator(
                //   controller: controller, // PageController
                //   count:  onboardImages.length,
                //   // forcing the indicator to use a specific direction
                //   effect:  ExpandingDotsEffect(
                //       dotHeight: 10.sp,
                //       dotWidth: 10.sp,
                //       dotColor: ColorConstants.dotsGreyColor,
                //       activeDotColor: ColorConstants.appPrimaryColor
                //   ),),
                // Container(
                //   padding: EdgeInsets.only(top: 120.sp,left: PaddingExtensions.screenLeftSidePadding,right: PaddingExtensions.screenRightSidePadding),
                //   alignment: Alignment.bottomCenter,
                //   child: Column(
                //     children: [
                //       Container(
                //           alignment: Alignment.center,
                //           height: 300.sp,
                //           child: Image.asset(onboardImages[index],height: 300.sp,fit: BoxFit.cover,)),
                //       SizedBox(
                //         height: 30.sp,
                //       ),
                //
                //       SizedBox(
                //         height: 20.sp,
                //       ),
                //     ],
                //   ),
                // ),

              ],
            )
          ),
          Container(
            height: Platform.isIOS?100.sp : 140.sp,
            width: double.infinity,
            padding:  Platform.isIOS?EdgeInsets.only(left: 12.sp,right: 12.sp,bottom: 40.sp,top: 10.sp): EdgeInsets.all( PaddingExtensions.screenOverAllPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomAppButton(
                  title: "Sign Up",
                  btnRadius: 12.sp,
                  fontWeight: FontWeight.w400,
                  onPress: (){
                    Navigator.of(context).pushNamed(RouteConstants.signupPageRoute);
                  },
                ),
                SizedBox(
                  height: 5.sp,
                ),
                CustomAppButton(
                  textWidget: Text.rich(
                    TextSpan(
                      text: "Already have an account?",
                      style: StaticTextStyle().boldTextStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: englishBold
                      ),
                      children: [
                        TextSpan(
                          text: " Sign in",
                          style: StaticTextStyle().boldTextStyle.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: englishBold,
                            decoration: TextDecoration.underline,
                            decorationColor: ColorConstants.whiteColor,
                            decorationThickness: 2.sp
                          ),
                        )
                      ]
                    )
                  ),
                  btnRadius: 12.sp,
                  onPress: (){

                    Navigator.of(context).pushNamed(RouteConstants.loginPageRoute,);
                  },
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}
