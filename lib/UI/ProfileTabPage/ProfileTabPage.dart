
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:linedup_app/Components/CacheNetworkImage/CacheNetworkImage.dart';
import 'package:linedup_app/Components/CustomAppButton/CustomAppButton.dart';
import 'package:linedup_app/Components/Extentions/PaddingExtentions.dart';
import 'package:linedup_app/Components/ProfilleBackgroundImage/ProfileBackgroundeImage.dart';
import 'package:linedup_app/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:linedup_app/Controllers/UserProfileService/UserProfileService.dart';
import 'package:linedup_app/Providers/UserProfileProvider/UserProfileProvider.dart';
import 'package:linedup_app/SharedPrefrences/SharedPrefrences.dart';
import 'package:linedup_app/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:linedup_app/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:linedup_app/Utils/Constants/Key_Constants.dart';
import 'package:linedup_app/Utils/Constants/RouteConstants/RouteConstants.dart';
import 'package:linedup_app/globals.dart';
import 'package:provider/provider.dart';

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

      body: Consumer<UserProfileProvider>(
        builder: (context, userProfileProvider,_) {
          var userProfile = userProfileProvider.userProfileResponseModel;
          return userProfile?.data==null?Center(
            child: CircularProgressIndicator(
              color: ColorConstants.appPrimaryColor,
            ),
          ) : Column(
            children: [
              SizedBox(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                      height: 240.sp,
                      width: double.infinity,
                      child: Image.asset(AssetConstants.profileBackGroundImage,fit: BoxFit.fitHeight,height: 220.sp,),
                    ),

                    Container(
                      height: 155.sp,
                      width: 155.sp,
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorConstants.appPrimaryColor,width: 1.sp),
                        shape: BoxShape.circle
                      ),
                      child: ClipOval(
                        clipBehavior: Clip.antiAlias,
                        child: ImageWidget(
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
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding:  EdgeInsets.only(top: 30.sp,right: 20.sp,left:20.sp),
                  child: Column(
                    children: [
                      Text(userProfile?.data?.userName??"",style: StaticTextStyle().boldTextStyle.copyWith(
                        fontSize: 18.sp,
                        color: ColorConstants.profileNameColor
                      ),),
                      Text("D.O.B ${userProfile?.data?.dob??""}",style: StaticTextStyle().regular.copyWith(
                        fontSize: 13.sp,
                        color: ColorConstants.textGreyColor
                      ),),
                      Text("Gender, ${userProfile?.data?.gender??""}",style: StaticTextStyle().regular.copyWith(
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
                            await SharedPreferencesService().remove(KeysConstants.accessToken, token);
                            Navigator.of(context).pushNamed(RouteConstants.loginPageRoute);
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
