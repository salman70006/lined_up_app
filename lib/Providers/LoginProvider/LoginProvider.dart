import 'package:flutter/material.dart';
import 'package:linedup_app/Models/AuthModels/LoginResponseModel/LoginResponseModel.dart';
import 'package:linedup_app/Models/EnableUserLocationResponseModel/EnableUserLocationResponseModel.dart';

class LoginProvider extends ChangeNotifier {
  LoginResponseModel? loginResponseModel;
  EnableUserLocationResponseModel? enableUserLocationResponseModel;
bool? isPasswordShow=true;
 toggle(data){
   isPasswordShow = !isPasswordShow!;
   notifyListeners();
 }
 loginDetails(LoginResponseModel data){
   loginResponseModel = data;
   notifyListeners();
 }

 enableLocation(EnableUserLocationResponseModel data){

   enableUserLocationResponseModel = data;
   notifyListeners();
 }
}