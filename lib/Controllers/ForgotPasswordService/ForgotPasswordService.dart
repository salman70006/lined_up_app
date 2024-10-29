import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:com.zat.linedup/API/api.dart';
import 'package:com.zat.linedup/API/api_response.dart';
import 'package:com.zat.linedup/ApiEndPoints/ApiEndPoints.dart';
import 'package:com.zat.linedup/Models/OTPRequestModel/OTPRequestModel.dart';
import 'package:com.zat.linedup/Models/OTPResponseModel/OTPResponseModel.dart';
import 'package:com.zat.linedup/Models/ResetPasswordRequestModel/ResetPasswordRequestModel.dart';
import 'package:com.zat.linedup/Models/ResetPasswordResponseModel/ResetPasswordResponseModel.dart';
import 'package:com.zat.linedup/Models/VerifyEmailRequestModel/VerifyEmailRequestModel.dart';
import 'package:com.zat.linedup/Models/VerifyEmailResponsetModel/VerifyEmailResponsetModel.dart';
import 'package:com.zat.linedup/Providers/ForgotPasswordPrvoider/ForgotPasswordProvider.dart';
import 'package:provider/provider.dart';

class ForgotPasswordService{

  Future<ApiResponse<VerifyEmailResponseModel>?>  verifyEmail(BuildContext context,String email)async{
    var verifyEmailProvider = Provider.of<ForgotPasswordProvider>(context,listen: false);
    VerifyEmailRequestModel verifyEmailRequestModel = VerifyEmailRequestModel(
        email:email ,

    );
    debugPrint("verify email Request Body:${verifyEmailRequestModel.email},");

    try{
      var response = await Api.postRequestData(ApiEndPoints.verifyEmail, verifyEmailRequestModel.toJson(), context,sendToken: true);
      debugPrint("verify email Api Response: $response");
      VerifyEmailResponseModel verifyEmailResponseModel = VerifyEmailResponseModel.fromJson(jsonDecode(response));
      debugPrint("verify email Api Model Response: ${verifyEmailResponseModel.toJson()}");
      verifyEmailProvider.verifyEmail(verifyEmailResponseModel);
      return ApiResponse.completed(verifyEmailResponseModel);
    }catch (e){
      debugPrint("verify email  Api Error Response: ${e.toString()}");
      return ApiResponse.error(e.toString());
    }
  }
  Future<ApiResponse<OTPResponseModel>?>  verifyOtp(BuildContext context,String otp)async{
    var verifyEmailProvider = Provider.of<ForgotPasswordProvider>(context,listen: false);
    OTPRequestModel otpRequestModel = OTPRequestModel(
        otp:otp ,

    );
    debugPrint("verify otp Request Body:${otpRequestModel.otp},");

    try{
      var response = await Api.postRequestData(ApiEndPoints.verifyOtp, otpRequestModel.toJson(), context,sendToken: true);
      debugPrint("verify otp Api Response: $response");
      OTPResponseModel otpResponseModel = OTPResponseModel.fromJson(jsonDecode(response));
      debugPrint("verify otp Api Model Response: ${otpResponseModel.toJson()}");
      verifyEmailProvider.verifyOtp(otpResponseModel);
      return ApiResponse.completed(otpResponseModel);
    }catch (e){
      debugPrint("verify email  Api Error Response: ${e.toString()}");
      return ApiResponse.error(e.toString());
    }
  }
  Future<ApiResponse<ResetPasswordResponseModel>?>  resetPassword(BuildContext context,String email,password,confirmPassword)async{
    var resetPasswordProvider = Provider.of<ForgotPasswordProvider>(context,listen: false);
    ResetPasswordRequestModel resetPasswordRequestModel = ResetPasswordRequestModel(
        email:email,
      password: password,
      confirmPassword: confirmPassword

    );
    debugPrint("Reset password Request Body:${resetPasswordRequestModel.email},${resetPasswordRequestModel.password},${resetPasswordRequestModel.confirmPassword}");

    try{
      var response = await Api.postRequestData(ApiEndPoints.resetPassword, resetPasswordRequestModel.toJson(), context,sendToken: true);
      debugPrint("Reset password Api Response: $response");
      ResetPasswordResponseModel resetPasswordResponseModel = ResetPasswordResponseModel.fromJson(jsonDecode(response));
      debugPrint("Reset password Api Model Response: ${resetPasswordResponseModel.toJson()}");
      resetPasswordProvider.resetPassword(resetPasswordResponseModel);
      return ApiResponse.completed(resetPasswordResponseModel);
    }catch (e){
      debugPrint("Reset password  Api Error Response: ${e.toString()}");
      return ApiResponse.error(e.toString());
    }
  }
}