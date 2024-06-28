
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linedup_app/Components/CustomAppButton/CustomAppButton.dart';
import 'package:linedup_app/SharedPrefrences/SharedPrefrences.dart';
import 'package:linedup_app/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:linedup_app/Utils/Constants/Key_Constants.dart';
import 'package:linedup_app/Utils/Constants/RouteConstants/RouteConstants.dart';
import 'package:linedup_app/globals.dart';
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
          Expanded(
            child: PageView.builder(
              controller: controller,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return  Column(
                  children: [
                    SizedBox(
                        width: double.infinity,
                        child: Image.asset(AssetConstants.onboardImage,fit: BoxFit.cover,height: 325.sp,width: double.infinity,)),
                    SizedBox(
                      height: 40.sp,
                    ),
                    Text(
                      "Why Wait?",
                      style: StaticTextStyle().boldTextStyle.copyWith(
                        color: ColorConstants.textGreyColor
                      ),
                    ),
                    Container(
                      padding:  EdgeInsets.only(left: 40.sp,right: 30.sp,top: 20.sp),
                      width: 313.sp,
                      child: Text(
                        "With LinedUp, you can reserve your spot in line days before the event begins.Waiting in lines is now a thing of the past, enjoy getting into events faster than ever when usingLinedUp!",
                        style: StaticTextStyle().regular.copyWith(
                          color: ColorConstants.textGreyColor,
                          height: 1.9.sp
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 50.sp,
                    ),
                    SmoothPageIndicator(
                      controller: controller, // PageController
                      count:  onboardImages.length,
                      // forcing the indicator to use a specific direction
                      effect:  ExpandingDotsEffect(
                          dotHeight: 10.sp,
                          dotWidth: 10.sp,
                          dotColor: ColorConstants.dotsGreyColor,
                          activeDotColor: ColorConstants.appPrimaryColor
                      ),),
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
                );


              },
              itemCount: onboardImages.length, // Can be null
            ),
          ),
          Container(
            height: 140.sp,
            width: double.infinity,
            padding: EdgeInsets.all(PaddingExtensions.screenOverAllPadding),
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
                  onPress: ()async{

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
