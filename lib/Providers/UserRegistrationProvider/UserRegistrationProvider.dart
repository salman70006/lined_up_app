import 'package:flutter/cupertino.dart';
import 'package:linedup_app/Models/AuthModels/UserRegistrationResponseModel/UserRegistrationResponseModel.dart';

class UserRegistrationProvider extends ChangeNotifier{
  bool? isRemember=false;
  bool? showPassword=true;
  UserRegistrationResponseModel? userRegistrationResponseModel;


  setUserRegistration(UserRegistrationResponseModel data){
    userRegistrationResponseModel = data;
    notifyListeners();
  }
  setValue(value){
    isRemember = value;
    debugPrint(
      "Value is::::$value"
    );
    notifyListeners();
  }
  passwordToggle(data){
    showPassword = !showPassword!;
    notifyListeners();
  }
}