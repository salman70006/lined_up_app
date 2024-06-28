import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linedup_app/Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import 'package:linedup_app/Controllers/ForgotPasswordService/ForgotPasswordService.dart';
import 'package:linedup_app/Utils/Constants/RouteConstants/RouteConstants.dart';
import 'package:pinput/pinput.dart';

import '../../../Components/BackButtonWidget/BackButtonWidget.dart';
import '../../../Components/CustomAppButton/CustomAppButton.dart';
import '../../../Components/Extentions/PaddingExtentions.dart';
import '../../../Components/StaticTextStyle/StaticTextStyle.dart';
import '../../../Utils/Constants/ColorConstants/ColorConstants.dart';

class OtpVerification extends StatefulWidget {
  var otp;
   OtpVerification({super.key,this.otp});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final formKey = GlobalKey<FormState>();
  final pinController = TextEditingController();
  final focusNode = FocusNode();
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pinController.dispose();
    focusNode.dispose();
  }
  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = ColorConstants.appPrimaryColor;
    const fillColor = ColorConstants.whiteColor;
    const borderColor = ColorConstants.appPrimaryColor;

    final defaultPinTheme = PinTheme(
      width: 70.sp,
      height: 60.sp,
      textStyle: const TextStyle(
        fontSize: 22,
        color: ColorConstants.blackColor,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.sp),
        border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: PaddingExtensions.screenTopPadding,left: PaddingExtensions.screenLeftSidePadding,right: PaddingExtensions.screenRightSidePadding),
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
                          "OTP Verification",
                          style: StaticTextStyle().boldTextStyle.copyWith(
                            fontSize: 30.sp,
                            color: ColorConstants.blackColor,
                            height: 2.sp,
                            letterSpacing: -1.sp,

                          ),
                        ),
                      ),
                      Text(
                        "Enter the verification code we just sent on your email address.",
                        style: StaticTextStyle().regular.copyWith(
                            color: ColorConstants.hintTextColor,
                            fontFamily: englishRegular,
                            fontSize: 16.sp
                        ),
                      ),
                      Padding(
                          padding:  EdgeInsets.symmetric(vertical: 40.sp),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Directionality(
                                  // Specify direction if desired
                                  textDirection: TextDirection.ltr,
                                  child: Pinput(
                                    controller: pinController,
                                    focusNode: focusNode,
                                    androidSmsAutofillMethod:
                                    AndroidSmsAutofillMethod.smsUserConsentApi,
                                    listenForMultipleSmsOnAndroid: true,
                                    defaultPinTheme: defaultPinTheme,
                                    // separatorBuilder: (index) => const SizedBox(width: 8),
                                    validator: (value) {
                                      if(value!.isEmpty){
                                        return "please enter otp!";
                                      }
                                    },
                                    // onClipboardFound: (value) {
                                    //   debugPrint('onClipboardFound: $value');
                                    //   pinController.setText(value);
                                    // },
                                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                                    onCompleted: (pin) {
                                      setState(() {
                                        widget.otp =pin;
                                      });
                                      debugPrint('onCompleted: $pin');
                                    },
                                    onChanged: (value) {
                                      debugPrint('onChanged: $value');
                                    },
                                    cursor: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(bottom: 9),
                                          width: 22,
                                          height: 1,
                                          color: focusedBorderColor,
                                        ),
                                      ],
                                    ),

                                    focusedPinTheme: defaultPinTheme.copyWith(
                                      decoration: defaultPinTheme.decoration!.copyWith(
                                        border: Border.all(color: focusedBorderColor),
                                        borderRadius: BorderRadius.circular(8.sp),

                                      ),
                                    ),
                                    submittedPinTheme: defaultPinTheme.copyWith(
                                      decoration: defaultPinTheme.decoration!.copyWith(
                                        color: fillColor,
                                        border: Border.all(color: focusedBorderColor),
                                        borderRadius: BorderRadius.circular(8.sp),

                                      ),
                                    ),
                                    errorPinTheme: defaultPinTheme.copyBorderWith(
                                      border: Border.all(color: Colors.redAccent),

                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),

                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 10.sp),
                        child: CustomAppButton(
                          title: "Verify",
                          fontWeight: FontWeight.w700,
                          fontSize: 15.sp,
                          fontFamily: englishBold,
                          onPress: ()async{
                           if(formKey.currentState!.validate()){
                             var response = await ForgotPasswordService().verifyOtp(context, pinController.text);
                             debugPrint("on Submit:$response");
                             if(response!.responseData?.success==true){
                               ShowMessage().showMessage(context,response.responseData!.message!, ColorConstants.appPrimaryColor);
                               Navigator.of(context).pushNamed(RouteConstants.createNewPasswordPage,arguments: response.responseData?.data?.email);

                             }else{
                               ShowMessage().showMessage(context,response.responseData!.message!, ColorConstants.redColor);

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
}
