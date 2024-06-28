import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:linedup_app/API/api_response.dart';
import 'package:linedup_app/Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import 'package:linedup_app/Controllers/UserRegistrationService/UserRegistrationService.dart';
import 'package:linedup_app/Models/AuthModels/UserRegistrationResponseModel/UserRegistrationResponseModel.dart';
import 'package:linedup_app/Providers/UserRegistrationProvider/UserRegistrationProvider.dart';
import 'package:linedup_app/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:linedup_app/globals.dart';
import 'package:provider/provider.dart';
import '../../../Components/BackButtonWidget/BackButtonWidget.dart';
import '../../../Components/CustomAppButton/CustomAppButton.dart';
import '../../../Components/CustomOutlineTextField/CustomOutlineTextField.dart';
import '../../../Components/Extentions/PaddingExtentions.dart';
import '../../../Components/SocialButtonWidget/SocialButtonWidget.dart';
import '../../../Components/StaticTextStyle/StaticTextStyle.dart';
import '../../../Providers/LoadingProvider/LoadingProvider.dart';
import '../../../Utils/Constants/AssetConstants/AssetConstants.dart';
import '../../../Utils/Constants/RouteConstants/RouteConstants.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController useNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
      Container(
        alignment: Alignment.bottomCenter,
        height: 40.sp,
        padding: EdgeInsets.all(PaddingExtensions.screenOverAllPadding),
        child: Text.rich(
            TextSpan(
                text: "Already have an account?",
                style: StaticTextStyle().boldTextStyle.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.doesNotHaveAccountColor,
                    fontFamily: englishRegular
                ),
                children: [
                  TextSpan(
                    text: " Login Now",
                    style: StaticTextStyle().boldTextStyle.copyWith(
                        fontSize: 15.sp,
                        color: ColorConstants.appPrimaryColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: englishBold
                    ),
                      recognizer: TapGestureRecognizer()..onTap = (){
                        Navigator.of(context).pushNamed(RouteConstants.loginPageRoute);
                      }
                  )
                ]
            )
        ),
      )
      ,
      body: Consumer2<UserRegistrationProvider,LoadingProvider>(
        builder: (context, userRegistrationProvider,loadingProvider,_) {
          return Padding(
            padding: EdgeInsets.only(top: PaddingExtensions.screenTopPadding,left: PaddingExtensions.screenLeftSidePadding,right: PaddingExtensions.screenRightSidePadding),
            child: Form(
              key: _formKey,
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
                              padding:  EdgeInsets.symmetric(vertical: 30.sp),
                              child: Text(
                                "Hello! Register to get \nstarted",
                                style: StaticTextStyle().boldTextStyle.copyWith(
                                  fontSize: 30.sp,
                                  color: ColorConstants.blackColor,
                                  height: 2.sp,
                                  letterSpacing: -1.sp,

                                ),
                              ),
                            ),
                            CustomOutlineTextFormField(
                              hintText: "Username",
                              controller: useNameController,
                              cursorColor: ColorConstants.textGreyColor,
                              focusNode: emailNode,
                              borderSideColor: ColorConstants.dotsGreyColor.withOpacity(0.2),
                              onChanged: (value){
                                FocusScope.of(context).requestFocus(emailNode);
                              },
                              validator: (value){
                                if (value!.isEmpty){
                                  return "UserName required";
                                }
                              },
                              filled: true,
                              filledColor: ColorConstants.socialButtonBorderColor,
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: 15.sp),
                              child: CustomOutlineTextFormField(
                                hintText: "Email",
                                controller: emailController,
                                cursorColor: ColorConstants.textGreyColor,
                                focusNode: passwordNode,
                                borderSideColor: ColorConstants.dotsGreyColor.withOpacity(0.2),
                                filled: true,

                                filledColor: ColorConstants.socialButtonBorderColor,
                                onChanged: (value){
                                  FocusScope.of(context).requestFocus(passwordNode);
                                },
                                validator: (value){
                                  if (value!.isEmpty){
                                    return "email is required.";
                                  }
                                },
                              ),
                            ),
                            CustomOutlineTextFormField(
                              hintText: "Password",
                              controller: passwordController,
                              cursorColor: ColorConstants.textGreyColor,
                              focusNode: confirmPasswordNode,
                              borderSideColor: ColorConstants.dotsGreyColor.withOpacity(0.2),
                              onChanged: (value){
                                FocusScope.of(context).requestFocus(confirmPasswordNode);
                              },
                              filled: true,
                              filledColor: ColorConstants.socialButtonBorderColor,
                              obscuringCharacter: "*",
                              validator: (value){
                                if (value!.isEmpty){
                                  return "password required";
                                }
                              },
                              obscureText: userRegistrationProvider.showPassword,
                              suffixIcon: InkWell(
                                onTap: (){
                                  userRegistrationProvider.passwordToggle(userRegistrationProvider.showPassword);
                                },
                                child: Container(
                                    height: 22.sp,
                                    width: 22.sp,
                                    padding: EdgeInsets.all(15.sp),
                                    child: SvgPicture.asset(AssetConstants.passwordHideShowIcon)),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: 15.sp),
                              child: CustomOutlineTextFormField(
                                hintText: "Confirm password",
                                controller: confirmController,
                                textInputAction: TextInputAction.done,
                                cursorColor: ColorConstants.textGreyColor,
                                borderSideColor: ColorConstants.dotsGreyColor.withOpacity(0.2),
                                filled: true,
                                filledColor: ColorConstants.socialButtonBorderColor,
                                obscureText: userRegistrationProvider.showPassword,
                                obscuringCharacter: "*",

                                validator: (value){
                                  if (value!.isEmpty){
                                    return "confirm password required";
                                  }
                                  if(value!=passwordController.text){
                                    return "password not match. ";
                                  }
                                },
                              ),

                            ),
                         loadingProvider.isLoading? Center(child: CircularProgressIndicator(color: ColorConstants.appPrimaryColor,)) : CustomAppButton(
                              title: "Register",
                              fontWeight: FontWeight.w700,
                              fontSize: 15.sp,
                              fontFamily: englishBold,
                              onPress: ()async{
                                if(_formKey.currentState!.validate()){
                                  loadingProvider.setLoading(true);
                                  ApiResponse<UserRegistrationResponseModel>? registrationResponse = await UserRegistrationService().userRegistration(context,useNameController.text,emailController.text, passwordController.text, "", "", "");
                                  loadingProvider.setLoading(false);

                                  debugPrint("on Button Print Registration Response:$registrationResponse");
                                  if(registrationResponse!.responseData?.data!=null && registrationResponse.status== Status.COMPLETED){
                                    ShowMessage().showMessage(context, "User registered Successfully!", ColorConstants.appPrimaryColor);
                                    Navigator.of(context).pushNamedAndRemoveUntil(RouteConstants.loginPageRoute, (route) => false);

                                  }else {
                                    ShowMessage().showMessage(context, "Internal Server Error", ColorConstants.redColor);
                                  }
                                }
                              },
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: 5.sp),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,

                                children: [
                                  Checkbox(
                                      activeColor: ColorConstants.appPrimaryColor,
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                      side: const BorderSide(
                                        color: ColorConstants.appPrimaryColor,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(3.sp)
                                      ),
                                      value:userRegistrationProvider.isRemember , onChanged: userRegistrationProvider.setValue),
                                  Text.rich(
                                      TextSpan(
                                          text: "Agree",
                                          style: StaticTextStyle().boldTextStyle.copyWith(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: ColorConstants.doesNotHaveAccountColor,
                                              fontFamily: englishRegular,
                                              letterSpacing: 0.5.sp

                                          ),
                                          children: [
                                            TextSpan(
                                                text: " terms & conditions",
                                                style: StaticTextStyle().regular.copyWith(
                                                    fontSize: 12.sp,
                                                    color: ColorConstants.appPrimaryColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: englishBold,
                                                  decoration: TextDecoration.underline,
                                                  decorationThickness: 1.sp,
                                                  decorationColor: ColorConstants.appPrimaryColor,
                                                    letterSpacing: 0.5.sp

                                                ),
                                                recognizer: TapGestureRecognizer()..onTap = (){
                                                  Navigator.of(context).pushNamed(RouteConstants.loginPageRoute);
                                                }
                                            ),
                                            TextSpan(
                                                text: " and ",
                                                style: StaticTextStyle().regular.copyWith(
                                                    fontSize: 12.sp,
                                                    color: ColorConstants.blackColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: englishBold,
                                                    letterSpacing: 0.5.sp

                                                ),
                                            ),
                                            TextSpan(
                                                text: " Privacy policy ",
                                                style: StaticTextStyle().regular.copyWith(
                                                    fontSize: 12.sp,
                                                    color: ColorConstants.appPrimaryColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: englishBold,
                                                    decoration: TextDecoration.underline,
                                                    decorationThickness: 1.sp,
                                                    decorationColor: ColorConstants.appPrimaryColor,
                                                  letterSpacing: 0.5.sp
                                                ),
                                            ),
                                          ]
                                      )
                                  ),

                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: ColorConstants.socialButtonBorderColor,
                                    thickness: 1.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.sp,
                                ),
                                Text(
                                  "Or Register with",
                                  style: StaticTextStyle().boldTextStyle.copyWith(
                                      color: ColorConstants.forgotPasswordColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: arimoBold
                                  ),
                                ),
                                SizedBox(
                                  width: 10.sp,
                                ),
                                Expanded(
                                  child: Divider(
                                    color: ColorConstants.socialButtonBorderColor,
                                    thickness: 1.sp,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: 20.sp),
                              child: Row(
                                children: [
                                  SocialButtonWidget(
                                    iconWidget: SvgPicture.asset(AssetConstants.facebookIcon),
                                    onPressed: (){},
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(left: 8.sp,right: 8.sp),
                                    child: SocialButtonWidget(
                                      iconWidget: SvgPicture.asset(AssetConstants.googleIcon),
                                      onPressed: (){},
                                    ),
                                  ),
                                  SocialButtonWidget(
                                    iconWidget: SvgPicture.asset(AssetConstants.appleIcon),
                                    onPressed: (){},
                                  )
                                ],
                              ),
                            )
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
