import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:com.zat.linedup/Components/CustomAppButton/CustomAppButton.dart';
import 'package:com.zat.linedup/Components/CustomOutlineTextField/CustomOutlineTextField.dart';
import 'package:com.zat.linedup/Components/Extentions/PaddingExtentions.dart';
import 'package:com.zat.linedup/Components/SocialButtonWidget/SocialButtonWidget.dart';
import 'package:com.zat.linedup/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:com.zat.linedup/Controllers/UserLoginService/UserLoginService.dart';
import 'package:com.zat.linedup/Models/AuthModels/LoginResponseModel/LoginResponseModel.dart';
import 'package:com.zat.linedup/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:com.zat.linedup/Providers/LoginProvider/LoginProvider.dart';
import 'package:com.zat.linedup/Providers/SocialLoginsAuthProvider/SocailLoginsAuthProvider.dart';
import 'package:com.zat.linedup/SharedPrefrences/SharedPrefrences.dart';
import 'package:com.zat.linedup/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:com.zat.linedup/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:com.zat.linedup/Utils/Constants/Key_Constants.dart';
import 'package:com.zat.linedup/Utils/Constants/RouteConstants/RouteConstants.dart';
import 'package:com.zat.linedup/globals.dart';
import 'package:provider/provider.dart';

import '../../../API/api_response.dart';
import '../../../Components/BackButtonWidget/BackButtonWidget.dart';
import '../../../Components/GetUserLocation/GetUserLocation.dart';
import '../../../Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';

class LoginPage extends StatefulWidget {
  var fromLogout;
  LoginPage({this.fromLogout});

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
      bottomNavigationBar: Container(
        alignment: Alignment.bottomCenter,
        height: 60.sp,
        padding: EdgeInsets.all(PaddingExtensions.screenOverAllPadding),
        child: Text.rich(TextSpan(
            text: "Don’t have an account?",
            style: StaticTextStyle().boldTextStyle.copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: ColorConstants.doesNotHaveAccountColor,
                fontFamily: arimoBold),
            children: [
              TextSpan(
                  text: " Register Now",
                  style: StaticTextStyle().boldTextStyle.copyWith(
                      fontSize: 15.sp,
                      color: ColorConstants.appPrimaryColor,
                      fontWeight: FontWeight.w700,
                      fontFamily: arimoBold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context)
                          .pushNamed(RouteConstants.signupPageRoute);
                    })
            ])),
      ),
      body: Consumer3<LoginProvider, LoadingProvider, SocialAuthProvider>(
          builder:
              (context, loginProvider, loadingProvider, socialAuthProvider, _) {
        return Padding(
          padding: EdgeInsets.only(
              top: PaddingExtensions.screenTopPadding,
              left: PaddingExtensions.screenLeftSidePadding,
              right: PaddingExtensions.screenRightSidePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.fromLogout == "logout"
                  ? SizedBox()
                  : BackButtonWidget(
                      icon: Icons.arrow_back_ios,
                      onPress: () {
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
                        padding: EdgeInsets.symmetric(vertical: 30.sp),
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
                        borderSideColor:
                            ColorConstants.dotsGreyColor.withOpacity(0.2),
                        onChanged: (value) {
                          FocusScope.of(context).requestFocus(passwordNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "email field required.";
                          }
                        },
                        filled: true,
                        filledColor: ColorConstants.socialButtonBorderColor,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.sp),
                        child: CustomOutlineTextFormField(
                          hintText: "Enter your password",
                          controller: passwordController,
                          textInputAction: TextInputAction.done,
                          cursorColor: ColorConstants.textGreyColor,
                          borderSideColor:
                              ColorConstants.dotsGreyColor.withOpacity(0.2),
                          filled: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "password field required";
                            }
                            if (value.length < 8) {
                              return "password must be 8 characters";
                            }
                          },
                          filledColor: ColorConstants.socialButtonBorderColor,
                          obscureText: loginProvider.isPasswordShow,
                          obscuringCharacter: "*",
                          suffixIcon: InkWell(
                            onTap: () {
                              loginProvider
                                  .toggle(loginProvider.isPasswordShow);
                            },
                            child: Container(
                                height: 22.sp,
                                width: 22.sp,
                                padding: EdgeInsets.all(15.sp),
                                child: SvgPicture.asset(
                                    AssetConstants.passwordHideShowIcon)),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                RouteConstants.forgotPasswordPageRoute);
                          },
                          child: Text(
                            "Forgot Password?",
                            style: StaticTextStyle().boldTextStyle.copyWith(
                                color: ColorConstants.forgotPasswordColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: arimoBold),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.sp),
                        child: loadingProvider.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: ColorConstants.appPrimaryColor,
                                ),
                              )
                            : CustomAppButton(
                                title: "Login",
                                fontWeight: FontWeight.w700,
                                fontSize: 15.sp,
                                fontFamily: arimoBold,
                                onPress: () async {
                                  context.read<SocialAuthProvider>().resetProfile();
                                  
                                  if (formKey.currentState!.validate()) {
                                    _currentPosition = await LocationHandler
                                        .getCurrentPosition();
                                    _currentAddress = await LocationHandler
                                        .getAddressFromLatLng(
                                            _currentPosition!);
                                    setState(() {});
                                    loadingProvider.setLoading(true);
                                    ApiResponse<LoginResponseModel>?
                                        loginResponse = await UserLoginService()
                                            .userLogin(
                                                context,
                                                emailController.text,
                                                passwordController.text,
                                                "",
                                                "",
                                                "",
                                                "");

                                    loadingProvider.setLoading(false);

                                    debugPrint(
                                        "on Button Print Login Response:$loginResponse");
                                    if (loginResponse!.responseData?.success ==
                                        true) {
                                      token = SharedPreferencesService()
                                          .setString(KeysConstants.accessToken,
                                              loginResponse.responseData?.token)
                                          .toString();
                                      print(token);
                                      var response = await UserLoginService()
                                          .enableLocation(
                                              context,
                                              _currentAddress!,
                                              _currentPosition!.latitude,
                                              _currentPosition!.longitude);
                                      print(response);
                                      ShowMessage().showMessage(
                                          context,
                                          "Login Successfully!",
                                          ColorConstants.appPrimaryColor);
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              RouteConstants.appBottomBarRoute,
                                              (route) => false);
                                    } else {
                                      ShowMessage().showMessage(
                                          context,
                                          "email or password is incorrect!",
                                          ColorConstants.redColor);
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
                                fontFamily: arimoBold),
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
                        padding: EdgeInsets.symmetric(vertical: 20.sp),
                        child: Row(
                          children: [
                            SocialButtonWidget(
                              iconWidget:
                                  SvgPicture.asset(AssetConstants.facebookIcon),
                              onPressed: () async {
                                await socialAuthProvider.signInWithFacebook();
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.sp, right: 8.sp),
                              child: SocialButtonWidget(
                                iconWidget:
                                    SvgPicture.asset(AssetConstants.googleIcon),
                                onPressed: () async {

                                  socialAuthProvider.handleGoogleSignIn();
                                  print(
                                      'socialAuthProvider.currentUser?.uid....${socialAuthProvider.currentUser?.uid}');
                                  _currentPosition = await LocationHandler
                                      .getCurrentPosition();
                                  _currentAddress = await LocationHandler
                                      .getAddressFromLatLng(_currentPosition!);
                                  setState(() {});
                                  var socialLoginResponse =
                                      await UserLoginService().userLogin(
                                    context,
                                    "",
                                    "",
                                    "Google",
                                    socialAuthProvider.setUserGoogleId,
                                    "",
                                    "",
                                  );
                                  print(
                                      'socialLoginResponse........${socialLoginResponse}');
                                  if (socialLoginResponse
                                          ?.responseData?.success ==
                                      true) {
                                    token = SharedPreferencesService()
                                        .setString(
                                            KeysConstants.accessToken,
                                            socialLoginResponse
                                                ?.responseData?.token)
                                        .toString();
                                    print(token);
                                    var response = await UserLoginService()
                                        .enableLocation(
                                            context,
                                            _currentAddress!,
                                            _currentPosition!.latitude,
                                            _currentPosition!.longitude);
                                    print(response);
                                    ShowMessage().showMessage(
                                        context,
                                        "Login Successfully!",
                                        ColorConstants.appPrimaryColor);
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            RouteConstants.appBottomBarRoute,
                                            (route) => false);
                                  }else{

                                    ShowMessage().showMessage(
                                        context,
                                        socialLoginResponse!.responseData!.errors!,
                                        ColorConstants.redColor);
                                  }
                                },
                              ),
                            ),
                            SocialButtonWidget(
                              iconWidget:
                                  SvgPicture.asset(AssetConstants.appleIcon),
                              onPressed: () async {
                                context.read<SocialAuthProvider>().resetProfile();

                                await socialAuthProvider.handleAppleSignIn();
                                print(
                                    'socialAuthProvider.currentUser?.uid apple.....${socialAuthProvider.currentUser?.uid}');
                                _currentPosition =
                                    await LocationHandler.getCurrentPosition();
                                print(
                                    'socialAuthProvider.currentUser?.uid apple _currentPosition.....${_currentPosition}');
                                _currentAddress =
                                    await LocationHandler.getAddressFromLatLng(
                                        _currentPosition!);
                                print(
                                    'socialAuthProvider.currentUser?.uid apple _currentAddress.....${_currentAddress}');
                                setState(() {});
                                var socialLoginResponse =
                                    await UserLoginService().userLogin(
                                        context,
                                        "",
                                        "",
                                        "Apple",
                                        '',
                                        socialAuthProvider.setUserAppleId,
                                        "");
                                print(
                                    'socialAuthProvider.currentUser?.uid apple socialLoginResponse.....${socialLoginResponse}');
                                if (socialLoginResponse
                                        ?.responseData?.success ==
                                    true) {
                                  token = SharedPreferencesService()
                                      .setString(
                                        KeysConstants.accessToken,
                                        socialLoginResponse
                                            ?.responseData?.token,
                                      )
                                      .toString();
                                  print(token);
                                  var response = await UserLoginService()
                                      .enableLocation(
                                          context,
                                          _currentAddress!,
                                          _currentPosition!.latitude,
                                          _currentPosition!.longitude);
                                  print(response);
                                  ShowMessage().showMessage(
                                      context,
                                      "Login Successfully!",
                                      ColorConstants.appPrimaryColor);
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      RouteConstants.appBottomBarRoute,
                                      (route) => false);
                                }
                              },
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
      }),
    );
  }
}
