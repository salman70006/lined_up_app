
import 'package:com.zat.linedup/Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import 'package:com.zat.linedup/Controllers/LogoutService/LogoutService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:com.zat.linedup/Components/CacheNetworkImage/CacheNetworkImage.dart';
import 'package:com.zat.linedup/Components/CustomAppButton/CustomAppButton.dart';
import 'package:com.zat.linedup/Components/Extentions/PaddingExtentions.dart';
import 'package:com.zat.linedup/Components/ProfilleBackgroundImage/ProfileBackgroundeImage.dart';
import 'package:com.zat.linedup/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:com.zat.linedup/Controllers/UserProfileService/UserProfileService.dart';
import 'package:com.zat.linedup/Providers/SocialLoginsAuthProvider/SocailLoginsAuthProvider.dart';
import 'package:com.zat.linedup/Providers/UserProfileProvider/UserProfileProvider.dart';
import 'package:com.zat.linedup/SharedPrefrences/SharedPrefrences.dart';
import 'package:com.zat.linedup/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:com.zat.linedup/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:com.zat.linedup/Utils/Constants/Key_Constants.dart';
import 'package:com.zat.linedup/Utils/Constants/RouteConstants/RouteConstants.dart';
import 'package:com.zat.linedup/globals.dart';
import 'package:provider/provider.dart';

import '../../Components/CustomWaveClipper.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({super.key});

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  UserProfileService userProfileService = UserProfileService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userProfileService.getUserProfile(context);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Consumer2<UserProfileProvider,SocialAuthProvider>(
        builder: (context, userProfileProvider,socialAuthProvider,_) {
          var userProfile = userProfileProvider.userProfileResponseModel;
          return userProfile?.data==null?Center(
            child: CircularProgressIndicator(
              color: ColorConstants.appPrimaryColor,
            ),
          ) : Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    // clipper: WaveClipper(),
                    child: Container(
                      height: 227.sp,
                      width: double.infinity,
                      color: ColorConstants.appPrimaryColor,
                      // child: Image.asset(AssetConstants.profileBackGroundImage,fit: BoxFit.fitHeight,height: 220.sp,),
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.only(top: 90.sp,left: 100.sp),
                    child: Container(
                      height: 155.sp,
                      width: 155.sp,
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorConstants.appPrimaryColor,width: 1.sp),
                          shape: BoxShape.circle
                      ),
                      child: ClipOval(
                        clipBehavior: Clip.antiAlias,
                        child: socialAuthProvider.currentUser?.photoURL!=null?ImageWidget(
                          height: 150.sp,
                          width: 150.sp,
                          fit: BoxFit.cover,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle
                          ),
                          imageUrl: socialAuthProvider.currentUser?.photoURL,

                        ) :ImageWidget(
                          height: 150.sp,
                          width: 150.sp,
                          fit: BoxFit.cover,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle
                          ),
                          imageUrl: userProfile?.data?.profileImage.toString(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: Padding(
                  padding:  EdgeInsets.only(top: 20.sp,right: 20.sp,left:20.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     socialAuthProvider.currentUser?.displayName!=null?Text( socialAuthProvider.currentUser?.displayName??"",style: StaticTextStyle().boldTextStyle.copyWith(
                         fontSize: 18.sp,
                         color: ColorConstants.profileNameColor
                     ),)  :Text(userProfile?.data?.userName??"",style: StaticTextStyle().boldTextStyle.copyWith(
                        fontSize: 18.sp,
                        color: ColorConstants.profileNameColor
                      ),),
                      Text("D.O.B ${userProfile?.data?.dob??""}",style: StaticTextStyle().regular.copyWith(
                        fontSize: 13.sp,
                        color: ColorConstants.textGreyColor
                      ),),
                      Text("Gender ${userProfile?.data?.gender??""}",style: StaticTextStyle().regular.copyWith(
                        fontSize: 13.sp,
                        color: ColorConstants.textGreyColor
                      ),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomAppButton(
                            title: "Edit profile",
                            height: 12.sp,
                            width: 80.sp,
                            btnRadius: 11.sp,
                            onPress: (){
                              Navigator.of(context).pushNamed(RouteConstants.editProfilePageRoute);
                            },
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed(RouteConstants.helpAndSupportPageRoute);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(AssetConstants.infoIcon,height: 22.sp,),
                            SizedBox(
                              width: 10.sp,
                            ),
                            Text(
                                "Help"
                            ,style: StaticTextStyle().boldTextStyle.copyWith(
                              fontSize: 18.sp,
                              color: ColorConstants.infoColor
                            ),
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 30.sp),
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed(RouteConstants.appPrivacyPolicyPageRoute);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(AssetConstants.infoIcon,height: 22.sp,),
                              SizedBox(
                                width: 10.sp,
                              ),
                              Text(
                                  "Privacy Policy"
                              ,style: StaticTextStyle().boldTextStyle.copyWith(
                                fontSize: 18.sp,
                                color: ColorConstants.infoColor
                              ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed(RouteConstants.appTermsAndConditions);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(AssetConstants.infoIcon,height: 22.sp,),
                            SizedBox(
                              width: 10.sp,
                            ),
                            Text(
                                "Terms and Conditions"
                            ,style: StaticTextStyle().boldTextStyle.copyWith(
                              fontSize: 18.sp,
                              color: ColorConstants.infoColor
                            ),
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 30.sp),
                        child: InkWell(
                          onTap: ()async{
                            if(userProfile?.data?.googleId!=null){
                              await SharedPreferencesService().remove(KeysConstants.accessToken, token);
                              socialAuthProvider.handleSignOut();
                              Navigator.of(context).pushNamedAndRemoveUntil(RouteConstants.loginPageRoute,arguments: "logout", (route) => false);

                            }else{
                              var response = await LogoutService().logoutUser(context);
                              if(response!.responseData!.success==true){
                                ShowMessage().showMessage(context, "Logout!", ColorConstants.redColor);
                                Navigator.of(context).pushNamedAndRemoveUntil(RouteConstants.loginPageRoute,arguments: "logout", (route) => false);

                              }

                            }

                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(AssetConstants.logoutIcon,height: 22.sp,),
                              SizedBox(
                                width: 10.sp,
                              ),
                              Text(
                                  "Logout"
                              ,style: StaticTextStyle().boldTextStyle.copyWith(
                                fontSize: 18.sp,
                                color: ColorConstants.redColor
                              ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ]);
        }
      )
            );
  }
}
