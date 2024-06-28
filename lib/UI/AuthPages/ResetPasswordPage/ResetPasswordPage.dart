
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:linedup_app/Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import 'package:linedup_app/Controllers/ForgotPasswordService/ForgotPasswordService.dart';
import 'package:linedup_app/Providers/ResetPasswordProvider/ResetpasswordProvider.dart';
import 'package:provider/provider.dart';

import '../../../Components/BackButtonWidget/BackButtonWidget.dart';
import '../../../Components/CustomAppButton/CustomAppButton.dart';
import '../../../Components/CustomOutlineTextField/CustomOutlineTextField.dart';
import '../../../Components/Extentions/PaddingExtentions.dart';
import '../../../Components/StaticTextStyle/StaticTextStyle.dart';
import '../../../Utils/Constants/AssetConstants/AssetConstants.dart';
import '../../../Utils/Constants/ColorConstants/ColorConstants.dart';
import '../../../Utils/Constants/RouteConstants/RouteConstants.dart';

class ResetPasswordPage extends StatefulWidget {
  var userEmail;
   ResetPasswordPage({this.userEmail});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ResetPasswordProvider>(
        builder: (context, resetPasswordProvider,_) {
          return Padding(
            padding: EdgeInsets.only(top: PaddingExtensions.screenTopPadding,left: PaddingExtensions.screenLeftSidePadding,right: PaddingExtensions.screenRightSidePadding),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackButtonWidget(
                    icon: Icons.arrow_back_ios,
                    onPress: (){
                      Navigator.of(context).pop();
                    },
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top: 30.sp,bottom: 20.sp),
                              child: Text(
                                "Create new password",
                                style: StaticTextStyle().boldTextStyle.copyWith(
                                  fontSize: 30.sp,
                                  color: ColorConstants.blackColor,
                                  height: 2.sp,
                                  letterSpacing: -1.sp,

                                ),
                              ),
                            ),
                            Text(
                              "Your new password must be unique from those previously used.",
                              style: StaticTextStyle().regular.copyWith(
                                  color: ColorConstants.hintTextColor,
                                  fontFamily: englishRegular,
                                  fontSize: 16.sp
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: 20.sp),
                              child: CustomOutlineTextFormField(
                                hintText: "New Password",
                                controller: newPasswordController,
                                cursorColor: ColorConstants.textGreyColor,
                                obscureText: resetPasswordProvider.showPassword,
                                obscuringCharacter: "*",
                                borderSideColor: ColorConstants.dotsGreyColor.withOpacity(0.2),
                                filled: true,
                                filledColor: ColorConstants.socialButtonBorderColor,
                                suffixIcon: InkWell(
                                  onTap: (){
                                    resetPasswordProvider.passwordToggle(resetPasswordProvider.showPassword);
                                  },
                                  child: Container(
                                      height: 22.sp,
                                      width: 22.sp,
                                      padding: EdgeInsets.all(15.sp),
                                      child: SvgPicture.asset(AssetConstants.passwordHideShowIcon)),
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "password field is required";
                                  }
                                },
                              ),
                            ),
                            CustomOutlineTextFormField(
                              hintText: "Confirm Password",
                              controller: confirmNewPasswordController,
                              cursorColor: ColorConstants.textGreyColor,
                              textInputAction: TextInputAction.done,
                              obscureText: resetPasswordProvider.showPassword,
                              obscuringCharacter: "*",
                              borderSideColor: ColorConstants.dotsGreyColor.withOpacity(0.2),
                              filled: true,
                              filledColor: ColorConstants.socialButtonBorderColor,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "confirm password is required";
                                }else if(newPasswordController.text != value){
                                  return "password not match.";
                                }
                              },
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: 30.sp),
                              child: CustomAppButton(
                                title: "Reset Password",
                                fontWeight: FontWeight.w700,
                                fontSize: 15.sp,
                                fontFamily: englishBold,
                                onPress: ()async{
                                  if(formKey.currentState!.validate()){
                                    var response = await ForgotPasswordService().resetPassword(context, widget.userEmail, newPasswordController.text, confirmNewPasswordController.text);
                                    debugPrint("On submit:$response");
                                    if(response!.responseData?.success==true){
                                      ShowMessage().showMessage(context, response.responseData!.message!, ColorConstants.appPrimaryColor);
                                      Navigator.of(context).pushNamed(RouteConstants.resetPasswordSuccessPage);


                                    }else{
                                      ShowMessage().showMessage(context, response.responseData!.message!, ColorConstants.redColor);

                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
