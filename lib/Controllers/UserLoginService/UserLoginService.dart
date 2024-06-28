
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:linedup_app/Models/AuthModels/LoginResponseModel/LoginResponseModel.dart';
import 'package:linedup_app/Models/AuthModels/loginRequestModel/LoginRequestModel.dart';
import 'package:linedup_app/Models/EnableUserLocationRequestModel/EnableUserLocationRequestModel.dart';
import 'package:linedup_app/Models/EnableUserLocationResponseModel/EnableUserLocationResponseModel.dart';
import 'package:linedup_app/Providers/LoginProvider/LoginProvider.dart';
import 'package:provider/provider.dart';

import '../../API/api.dart';
import '../../API/api_response.dart';
import '../../ApiEndPoints/ApiEndPoints.dart';
import '../../globals.dart';

class UserLoginService {

  Future<ApiResponse<LoginResponseModel>?>  userLogin(BuildContext context,String email,password,loginType,googleId,appleId,facebookId)async{
    var loginProvider = Provider.of<LoginProvider>(context,listen: false);
   LoginRequestModel loginRequestModel = LoginRequestModel(
     email:email ,
     password:password ,
     loginType: loginType,
     googleId: googleId,
     facebookId: facebookId,
     appleId: appleId,
     fcmToken: fcmToken
   );
    debugPrint("registration Request Body:${loginRequestModel.email},${loginRequestModel.password},${loginRequestModel.loginType},${loginRequestModel.googleId},${loginRequestModel.appleId},${loginRequestModel.facebookId},${loginRequestModel.fcmToken}");

    try{
      var response = await Api.postRequestData(ApiEndPoints.loginApi, loginRequestModel, context,sendToken: true);
      debugPrint("Login Api Response: $response");
      LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(jsonDecode(response));
      debugPrint("Login Api Model Response: ${loginResponseModel.toJson()}");
      loginProvider.loginDetails(loginResponseModel);
      return ApiResponse.completed(loginResponseModel);
    }catch (e){
      debugPrint("Login Api Error Response: ${e.toString()}");
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<EnableUserLocationResponseModel>?> enableLocation(BuildContext context,String location,double latitude,longitude)async{
    
    var enableLocationProvider = Provider.of<LoginProvider>(context,listen: false);
    
    EnableUserLocationRequestModel enableUserLocationRequestModel = EnableUserLocationRequestModel(
      location: location,
      latitude: latitude,
      longitude: longitude,
    );
    debugPrint("Enable Location Model :${jsonEncode(enableUserLocationRequestModel)}");
    
    try{
      var response = await Api.postRequestData(ApiEndPoints.enableLocation, enableUserLocationRequestModel.toJson(), context,sendToken: true);
      debugPrint("Enable Location Api :$response");
      EnableUserLocationResponseModel enableUserLocationResponseModel = EnableUserLocationResponseModel.fromJson(jsonDecode(response));
      debugPrint("Enable Location Model :${enableUserLocationResponseModel.toJson()}");
      enableLocationProvider.enableLocation(enableUserLocationResponseModel);
      return ApiResponse.completed(enableUserLocationResponseModel);
    } catch (e){
      debugPrint("Enable Location Error :${e.toString()}");
      return ApiResponse.error(e.toString());
    }
    
  }

}