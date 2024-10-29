import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:com.zat.linedup/Components/CustomOutlineTextField/CustomOutlineTextField.dart';
import 'package:com.zat.linedup/Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import 'package:com.zat.linedup/Controllers/UpdateProfileService/UpdateProfileService.dart';
import 'package:com.zat.linedup/Controllers/UserProfileService/UserProfileService.dart';
import 'package:com.zat.linedup/Providers/EditProfileProvider/EditProfileProvider.dart';
import 'package:com.zat.linedup/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:com.zat.linedup/Providers/SocialLoginsAuthProvider/SocailLoginsAuthProvider.dart';
import 'package:com.zat.linedup/Providers/UserProfileProvider/UserProfileProvider.dart';
import 'package:provider/provider.dart';

import '../../Components/CacheNetworkImage/CacheNetworkImage.dart';
import '../../Components/CustomAppButton/CustomAppButton.dart';
import '../../Components/CustomWaveClipper.dart';
import '../../Components/StaticTextStyle/StaticTextStyle.dart';
import '../../Utils/Constants/AssetConstants/AssetConstants.dart';
import '../../Utils/Constants/ColorConstants/ColorConstants.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  final GlobalKey<FormState> formKey = GlobalKey();
  final formattedDate = DateFormat('yyyy-MM-d');
  var results;

  List<DateTime>? dateTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var profileData = Provider.of<UserProfileProvider>(context, listen: false)
        .userProfileResponseModel
        ?.data;
    var socialUserData =
        Provider.of<SocialAuthProvider>(context, listen: false).currentUser;
    nameController = TextEditingController(
        text: profileData?.userName ??
            nameController?.text ??
            socialUserData?.displayName);
    emailController = TextEditingController(
        text: profileData?.email ??
            emailController?.text ??
            socialUserData?.email);
    passwordController = TextEditingController(text: "****");
    return Scaffold(
      body: Consumer3<SocialAuthProvider, EditProfileProvider, LoadingProvider>(
          builder: (context, socialAuthProvider, editProfileProvider,
              loadingProvider, _) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                padding: EdgeInsets.only(
                  top: Platform.isIOS ? 45.sp : 30.sp,
                  left: 20.sp,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 25.sp,
                              color: ColorConstants.whiteColor,
                            )),
                        Text(
                          "Edit Profile",
                          style: StaticTextStyle().boldTextStyle.copyWith(
                                fontSize: 20.sp,
                              ),
                        ),
                        SizedBox(
                          width: 45.sp,
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60.sp, right: 15.sp),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          InkWell(
                            onTap: () {
                              editProfileProvider
                                  .uploadImage(ImageSource.gallery);
                            },
                            child: Container(
                              height: 155.sp,
                              width: 155.sp,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorConstants.appPrimaryColor,
                                      width: 1.sp),
                                  shape: BoxShape.circle),
                              child: editProfileProvider.file != null
                                  ? ClipOval(
                                      clipBehavior: Clip.antiAlias,
                                      child: Image.file(
                                        editProfileProvider.file!,
                                        fit: BoxFit.cover,
                                        height: 155.sp,
                                        width: 155.sp,
                                      ))
                                  : socialAuthProvider.currentUser?.photoURL !=
                                          null
                                      ? ClipOval(
                                          clipBehavior: Clip.antiAlias,
                                          child: ImageWidget(
                                            height: 150.sp,
                                            width: 150.sp,
                                            fit: BoxFit.cover,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle),
                                            imageUrl: socialAuthProvider
                                                .currentUser?.photoURL,
                                          ),
                                        )
                                      : profileData!.profileImage!.isEmpty? ClipOval(
                                          clipBehavior: Clip.antiAlias,
                                          child: Container(
                                            height: 1508.sp,
                                            width: 150.sp,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle),
                                            child: Image.asset(
                                              AssetConstants.avtar,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : ClipOval(
                                          clipBehavior: Clip.antiAlias,
                                          child: Container(
                                            height: 1508.sp,
                                            width: 150.sp,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle),
                                            child: Image.network(
                                              profileData.profileImage.toString(),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                            ),
                          ),
                          SvgPicture.asset(
                            AssetConstants.cameraIcon,
                            color: ColorConstants.appPrimaryColor,
                          )
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
                padding: EdgeInsets.only(top: 20.sp, right: 20.sp, left: 20.sp),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: StaticTextStyle().boldTextStyle.copyWith(
                              fontSize: 18.sp,
                              color: ColorConstants.blackColor,
                            ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.sp),
                        child: CustomOutlineTextFormField(
                          borderSideColor:
                              ColorConstants.profileFieldsBorderColor,
                          cursorColor: ColorConstants.blackColor,
                          controller: nameController,
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      Text(
                        "Email",
                        style: StaticTextStyle().boldTextStyle.copyWith(
                              fontSize: 18.sp,
                              color: ColorConstants.blackColor,
                            ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.sp),
                        child: CustomOutlineTextFormField(
                          borderSideColor:
                              ColorConstants.profileFieldsBorderColor,
                          cursorColor: ColorConstants.blackColor,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Text(
                        "Password",
                        style: StaticTextStyle().boldTextStyle.copyWith(
                              fontSize: 18.sp,
                              color: ColorConstants.blackColor,
                            ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.sp),
                        child: CustomOutlineTextFormField(
                          borderSideColor:
                              ColorConstants.profileFieldsBorderColor,
                          cursorColor: ColorConstants.blackColor,
                          controller: passwordController,
                          obscureText: true,
                          obscuringCharacter: "*",
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      Text(
                        "Date of Birth",
                        style: StaticTextStyle().boldTextStyle.copyWith(
                              fontSize: 18.sp,
                              color: ColorConstants.blackColor,
                            ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.sp),
                        child: InkWell(
                            onTap: () async {
                              DateTime? selected = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1960),
                                lastDate: DateTime(2050),
                                initialDate: DateTime.now(),
                              );
                              if (selected != null) {
                                setState(() {
                                  results = selected;
                                });
                              }
                            },
                            child: Container(
                              height: 55.sp,
                              padding: EdgeInsets.symmetric(horizontal: 12.sp),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        ColorConstants.profileFieldsBorderColor,
                                    width: 1.sp),
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    results == null
                                        ? profileData!.dob.toString()
                                        : formattedDate.format(
                                            DateTime.parse(results.toString())),
                                    style: StaticTextStyle().regular.copyWith(
                                        color: ColorConstants.blackColor),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 16.sp,
                                  ),
                                ],
                              ),
                            )),
                      ),
                      Text(
                        "Gender",
                        style: StaticTextStyle().boldTextStyle.copyWith(
                              fontSize: 18.sp,
                              color: ColorConstants.blackColor,
                            ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.sp),
                        child: Container(
                          height: 57.sp,
                          child: DropdownButtonFormField(
                            elevation: 0,
                            isDense: true,
                            hint: Text(
                              "Select gender",
                              style: StaticTextStyle()
                                  .regular
                                  .copyWith(color: ColorConstants.blackColor),
                            ),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 16.sp,
                              color: ColorConstants.blackColor,
                            ),
                            padding: EdgeInsets.zero,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color:
                                      ColorConstants.profileFieldsBorderColor,
                                ),
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color:
                                      ColorConstants.profileFieldsBorderColor,
                                ),
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color:
                                      ColorConstants.profileFieldsBorderColor,
                                ),
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                            ),
                            dropdownColor: ColorConstants.whiteColor,
                            value: profileData?.gender ??
                                editProfileProvider.selectedGender,
                            items: editProfileProvider.genderList.map((value) {
                              return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    "${value}",
                                    style: StaticTextStyle().regular.copyWith(
                                        color: ColorConstants.blackColor),
                                  ));
                            }).toList(),
                            onChanged: (newValue) {
                              editProfileProvider
                                  .setSelectedGender(newValue.toString());
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            loadingProvider.isLoading
                                ? CircularProgressIndicator(
                                    color: ColorConstants.appPrimaryColor,
                                  )
                                : CustomAppButton(
                                    title: "Save changes",
                                    fontSize: 20.sp,
                                    height: 44.sp,
                                    width: 220.sp,
                                    btnRadius: 6.sp,
                                    onPress: () async {
                                      if (formKey.currentState!.validate()) {
                                        loadingProvider.setLoading(true);
                                        var response =
                                            await UpdateProfileService()
                                                .updateProfile(
                                                    context,
                                                    nameController!
                                                            .text.isEmpty
                                                        ? socialUserData!
                                                            .displayName
                                                            .toString()
                                                        : nameController!.text,
                                                    emailController!
                                                            .text.isEmpty
                                                        ? socialUserData!.email
                                                        : emailController?.text,
                                                    "12345678",
                                                    results ==
                                                            null
                                                        ? profileData!.dob
                                                        : formattedDate
                                                            .format(DateTime
                                                                .parse(results
                                                                    .toString())),
                                                    profileData
                                                            ?.gender ??
                                                        editProfileProvider
                                                            .selectedGender);
                                        print(response);
                                        loadingProvider.setLoading(false);
                                        if (response?.responseData?.success ==
                                            true) {
                                          ShowMessage().showMessage(
                                              context,
                                              response!.responseData!.message!,
                                              ColorConstants.appPrimaryColor);
                                          UserProfileService()
                                              .getUserProfile(context);
                                          Navigator.of(context).pop();
                                        } else {
                                          ShowMessage().showMessage(
                                              context,
                                              "${response?.responseData?.message.toString()}",
                                              ColorConstants.redColor);
                                        }
                                      }
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
          ),
        ]);
      }),
    );
  }
}
