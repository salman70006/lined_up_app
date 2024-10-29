
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:com.zat.linedup/Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import 'package:com.zat.linedup/Controllers/ForgotPasswordService/ForgotPasswordService.dart';
import 'package:com.zat.linedup/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:com.zat.linedup/Utils/Constants/RouteConstants/RouteConstants.dart';
import 'package:provider/provider.dart';

import '../../../Components/BackButtonWidget/BackButtonWidget.dart';
import '../../../Components/CustomAppButton/CustomAppButton.dart';
import '../../../Components/CustomOutlineTextField/CustomOutlineTextField.dart';
import '../../../Components/Extentions/PaddingExtentions.dart';
import '../../../Components/StaticTextStyle/StaticTextStyle.dart';
import '../../../Utils/Constants/ColorConstants/ColorConstants.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                            "Forgot Password?",
                            style: StaticTextStyle().boldTextStyle.copyWith(
                              fontSize: 30.sp,
                              color: ColorConstants.blackColor,
                              height: 2.sp,
                              letterSpacing: -1.sp,

                            ),
                          ),
                        ),
                        Text(
                           "Don't worry! It happens. Please enter the email address linked with your account.",
                          style: StaticTextStyle().regular.copyWith(
                            color: ColorConstants.hintTextColor,
                            fontFamily: englishRegular,
                            fontSize: 16.sp
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(vertical: 20.sp),
                          child: CustomOutlineTextFormField(
                            hintText: "Enter your email",
                            controller: emailController,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Email field is required.";
                              }
                            },
                            cursorColor: ColorConstants.textGreyColor,
                            borderSideColor: ColorConstants.dotsGreyColor.withOpacity(0.2),
                            filled: true,
                            filledColor: ColorConstants.socialButtonBorderColor,
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.symmetric(vertical: 10.sp),
                          child: Consumer<LoadingProvider>(
                            builder: (context, loadingProvider,_) {
                              return loadingProvider.isLoading?Center(child: CircularProgressIndicator(color: ColorConstants.appPrimaryColor,)) :CustomAppButton(
                                title: "Send Code",
                                fontWeight: FontWeight.w700,
                                fontSize: 15.sp,
                                fontFamily: englishBold,
                                onPress: ()async{
                                  if(formKey.currentState!.validate()){
                                    loadingProvider.setLoading(true);
                                    var response = await ForgotPasswordService().verifyEmail(context, emailController.text);
                                    debugPrint("on Submitt:$response");
                                    loadingProvider.setLoading(false);
                                    if(response!.responseData?.success==true){
                                      ShowMessage().showMessage(context, response.responseData!.message.toString(), ColorConstants.appPrimaryColor);
                                      Navigator.of(context).pushNamed(RouteConstants.otpVerification,arguments: response.responseData?.data);

                                    }else{
                                      ShowMessage().showMessage(context, response.responseData!.message.toString(), ColorConstants.redColor);

                                    }
                                  }
                                },
                              );
                            }
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
