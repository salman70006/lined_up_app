import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/Models/OTPResponseModel/OTPResponseModel.dart';
import 'package:com.zat.linedup/Models/ResetPasswordResponseModel/ResetPasswordResponseModel.dart';
import 'package:com.zat.linedup/Models/VerifyEmailResponsetModel/VerifyEmailResponsetModel.dart';

class ForgotPasswordProvider extends ChangeNotifier{

  VerifyEmailResponseModel? verifyEmailResponseModel;
  OTPResponseModel? otpResponseModel;
  ResetPasswordResponseModel? resetPasswordResponseModel;
  verifyEmail(VerifyEmailResponseModel data){
    verifyEmailResponseModel=data;
    notifyListeners();
  }
  verifyOtp(OTPResponseModel data){
    otpResponseModel = data;
    notifyListeners();
  }
  resetPassword(ResetPasswordResponseModel data){
    resetPasswordResponseModel =data;
    notifyListeners();
  }
}