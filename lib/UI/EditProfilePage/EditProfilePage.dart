import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:linedup_app/Components/CustomOutlineTextField/CustomOutlineTextField.dart';
import 'package:linedup_app/Components/Extentions/PaddingExtentions.dart';
import 'package:linedup_app/Components/customWaveClipper.dart';

import '../../Components/CacheNetworkImage/CacheNetworkImage.dart';
import '../../Components/CustomAppButton/CustomAppButton.dart';
import '../../Components/StaticTextStyle/StaticTextStyle.dart';
import '../../Utils/Constants/AssetConstants/AssetConstants.dart';
import '../../Utils/Constants/ColorConstants/ColorConstants.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController(text: "Melissa Peters");
  TextEditingController emailController = TextEditingController(text: "melpeters@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "123455666");
  TextEditingController dobController = TextEditingController(text: "13/03/2000");
  TextEditingController genderController = TextEditingController(text: "Female");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    height: 227.sp,
                    width: double.infinity,
                    color: Colors.yellow,
                    // child: Image.asset(AssetConstants.profileBackGroundImage,fit: BoxFit.fitHeight,height: 220.sp,),
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.only(top: 30.sp,left: 20.sp,right: 20.sp),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap:(){
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.arrow_back_ios,size: 25.sp,color: ColorConstants.whiteColor,)),
                          Text("Edit Profile",
                          style: StaticTextStyle().boldTextStyle.copyWith(
                            fontSize:20.sp,
                          ),),
                          SizedBox()
                        ],
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: 50.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Container(
                                  height: 155.sp,
                                  width: 155.sp,
                                  margin: EdgeInsets.only(left: 40.sp),
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
                                      imageUrl: AssetConstants.profileImage,
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(AssetConstants.cameraIcon,color: ColorConstants.appPrimaryColor,)
                              ],
                            ),
                            SvgPicture.asset(AssetConstants.cameraIcon,),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.only(top: 20.sp,right: 20.sp,left:20.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name",style: StaticTextStyle().boldTextStyle.copyWith(
                          fontSize: 18.sp,
                          color: ColorConstants.blackColor,
                      ),),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical:10.sp),
                        child: CustomOutlineTextFormField(
                          borderSideColor: ColorConstants.profileFieldsBorderColor,
                          cursorColor: ColorConstants.blackColor,
                          controller: nameController,
                          keyboardType: TextInputType.name,
                
                        ),
                      ),
                      Text("Email",style: StaticTextStyle().boldTextStyle.copyWith(
                        fontSize: 18.sp,
                        color: ColorConstants.blackColor,
                      ),),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical:10.sp),
                        child: CustomOutlineTextFormField(
                          borderSideColor: ColorConstants.profileFieldsBorderColor,
                          cursorColor: ColorConstants.blackColor,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                
                        ),
                      ),
                      Text("Password",style: StaticTextStyle().boldTextStyle.copyWith(
                        fontSize: 18.sp,
                        color: ColorConstants.blackColor,
                      ),),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical:10.sp),
                        child: CustomOutlineTextFormField(
                          borderSideColor: ColorConstants.profileFieldsBorderColor,
                          cursorColor: ColorConstants.blackColor,
                          controller: passwordController,
                          obscureText: true,
                          obscuringCharacter: "*",
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      Text("Date of Birth",style: StaticTextStyle().boldTextStyle.copyWith(
                        fontSize: 18.sp,
                        color: ColorConstants.blackColor,
                      ),),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical:10.sp),
                        child: CustomOutlineTextFormField(
                          borderSideColor: ColorConstants.profileFieldsBorderColor,
                          cursorColor: ColorConstants.blackColor,
                          controller: dobController,
                          readOnly: true,
                          suffixIcon: Icon(Icons.keyboard_arrow_down,size: 17.sp,),
                
                        ),
                      ),
                      Text("Gender",style: StaticTextStyle().boldTextStyle.copyWith(
                        fontSize: 18.sp,
                        color: ColorConstants.blackColor,
                      ),),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical:10.sp),
                        child: CustomOutlineTextFormField(
                          borderSideColor: ColorConstants.profileFieldsBorderColor,
                          cursorColor: ColorConstants.blackColor,
                          controller: genderController,
                          suffixIcon: Icon(Icons.keyboard_arrow_down,size: 17.sp,),
                
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 20.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomAppButton(
                              title: "Save changes",
                              fontSize: 20.sp,
                              height: 44.sp,
                              width: 220.sp,
                              btnRadius: 6.sp,
                              onPress: (){
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
