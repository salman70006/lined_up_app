import 'package:flutter/cupertino.dart';
import 'package:linedup_app/Models/OTPResponseModel/OTPResponseModel.dart';
import 'package:linedup_app/Models/ResetPasswordResponseModel/ResetPasswordResponseModel.dart';
import 'package:linedup_app/Models/VerifyEmailResponsetModel/VerifyEmailResponsetModel.dart';

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