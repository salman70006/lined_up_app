import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:linedup_app/Components/CustomAppButton/CustomAppButton.dart';
import 'package:linedup_app/Components/CustomOutlineTextField/CustomOutlineTextField.dart';
import 'package:linedup_app/Components/Extentions/PaddingExtentions.dart';
import 'package:linedup_app/Components/SocialButtonWidget/SocialButtonWidget.dart';
import 'package:linedup_app/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:linedup_app/Controllers/UserLoginService/UserLoginService.dart';
import 'package:linedup_app/Models/AuthModels/LoginResponseModel/LoginResponseModel.dart';
import 'package:linedup_app/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:linedup_app/Providers/LoginProvider/LoginProvider.dart';
import 'package:linedup_app/SharedPrefrences/SharedPrefrences.dart';
import 'package:linedup_app/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:linedup_app/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:linedup_app/Utils/Constants/Key_Constants.dart';
import 'package:linedup_app/Utils/Constants/RouteConstants/RouteConstants.dart';
import 'package:linedup_app/globals.dart';
import 'package:provider/provider.dart';

import '../../../API/api_response.dart';
import '../../../Components/BackButtonWidget/BackButtonWidget.dart';
import '../../../Components/GetUserLocation/GetUserLocation.dart';
import '../../../Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  FocusNode passwordNode = FocusNode();
  String? _currentAddress;
  Position? _currentPosition;

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
                text: "Don’t have an account?",
                style: StaticTextStyle().boldTextStyle.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.doesNotHaveAccountColor,
                    fontFamily: arimoBold
                ),
                children: [
                  TextSpan(
                    text: " Register Now",
                    style: StaticTextStyle().boldTextStyle.copyWith(
                        fontSize: 15.sp,
                        color: ColorConstants.appPrimaryColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: arimoBold
                    ),
                    recognizer: TapGestureRecognizer()..onTap = (){
                      Navigator.of(context).pushNamed(RouteConstants.signupPageRoute);
                    }
                  )
                ]
            )
        ),
      )
      ,
      body: Consumer2<LoginProvider,LoadingProvider>(
        builder: (context, loginProvider,loadingProvider,_) {
          return Padding(
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
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                        Padding(
                          padding:  EdgeInsets.symmetric(vertical: 30.sp),
                          child: Text(
                            "Welcome back! Glad\nto see you, Again!",
                            style: StaticTextStyle().boldTextStyle.copyWith(
                              fontSize: 30.sp,
                              color: ColorConstants.blackColor,
                              height: 2.sp,
                              letterSpacing: -1.sp,

                            ),
                          ),
                        ),
                        CustomOutlineTextFormField(
                          hintText: "Enter your email",
                          controller: emailController,
                          cursorColor: ColorConstants.textGreyColor,
                          focusNode: passwordNode,
                          borderSideColor: ColorConstants.dotsGreyColor.withOpacity(0.2),
                          onChanged: (value){
                            FocusScope.of(context).requestFocus(passwordNode);
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "email field required.";
                            }
                          },
                          filled: true,
                          filledColor: ColorConstants.socialButtonBorderColor,
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(vertical: 15.sp),
                          child: CustomOutlineTextFormField(
                            hintText: "Enter your password",
                            controller: passwordController,
                            textInputAction: TextInputAction.done,
                            cursorColor: ColorConstants.textGreyColor,
                            borderSideColor: ColorConstants.dotsGreyColor.withOpacity(0.2),
                            filled: true,
                            validator: (value){
                              if(value!.isEmpty){
                                return "password field required";
                              }
                              if(value.length < 8){
                                return "password must be 8 characters";
                              }
                            },
                            filledColor: ColorConstants.socialButtonBorderColor,
                            obscureText: loginProvider.isPasswordShow,
                            obscuringCharacter: "*",
                            suffixIcon: InkWell(
                              onTap: (){
                                loginProvider.toggle(loginProvider.isPasswordShow);
                              },
                              child: Container(
                                  height: 22.sp,
                                  width: 22.sp,
                                  padding: EdgeInsets.all(15.sp),
                                  child: SvgPicture.asset(AssetConstants.passwordHideShowIcon)),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).pushNamed(RouteConstants.forgotPasswordPageRoute);
                            },
                            child: Text(
                              "Forgot Password?",
                            style: StaticTextStyle().boldTextStyle.copyWith(
                              color: ColorConstants.forgotPasswordColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: arimoBold
                            ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(vertical: 20.sp),
                          child: loadingProvider.isLoading? Center(
                            child: CircularProgressIndicator(
                              color: ColorConstants.appPrimaryColor,
                            ),
                          ):CustomAppButton(
                            title: "Login",
                            fontWeight: FontWeight.w700,
                            fontSize: 15.sp,
                            fontFamily: arimoBold,
                            onPress: ()async{
                              if(formKey.currentState!.validate()){
                                _currentPosition = await LocationHandler.getCurrentPosition();
                                _currentAddress = await LocationHandler.getAddressFromLatLng(
                                    _currentPosition!);
                                setState(() {});
                                loadingProvider.setLoading(true);
                                ApiResponse<LoginResponseModel>? loginResponse = await UserLoginService().userLogin(context,emailController.text, passwordController.text, "", "", "",fcmToken);

                                loadingProvider.setLoading(false);

                                debugPrint("on Button Print Login Response:$loginResponse");
                                if(loginResponse!.responseData?.data!=null && loginResponse.status== Status.COMPLETED){
                                 token = SharedPreferencesService().setString(KeysConstants.accessToken, loginResponse.responseData?.token).toString();
                                 print(token);
                                 var response = await UserLoginService().enableLocation(context, _currentAddress!, _currentPosition!.latitude, _currentPosition!.longitude);
                                 print(response);
                                  ShowMessage().showMessage(context, "Login Successfully!", ColorConstants.appPrimaryColor);
                                  Navigator.of(context).pushNamedAndRemoveUntil(RouteConstants.appBottomBarRoute, (route) => false);

                                }else {
                                  ShowMessage().showMessage(context, "email or password is incorrect!", ColorConstants.redColor);
                                }
                              }
                            },
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
                                "Or Login with",
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
                      ),
                    )),
              ],
            ),
          );
        }
      ),
    );
  }

}
