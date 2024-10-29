
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/API/api.dart';
import 'package:com.zat.linedup/API/api_response.dart';
import 'package:com.zat.linedup/ApiEndPoints/ApiEndPoints.dart';
import 'package:com.zat.linedup/Models/AuthModels/UserRegistrationRequestModel/UserRegistrationRequestModel.dart';
import 'package:com.zat.linedup/Models/AuthModels/UserRegistrationResponseModel/UserRegistrationResponseModel.dart';
import 'package:com.zat.linedup/Providers/UserRegistrationProvider/UserRegistrationProvider.dart';
import 'package:provider/provider.dart';

class UserRegistrationService {
Future<ApiResponse<UserRegistrationResponseModel>?>  userRegistration(BuildContext context,String name,lastName,userEmail,userPassword,googleId,appleId,facebookId)async{
  var registrationProvider = Provider.of<UserRegistrationProvider>(context,listen: false);
  UserRegistrationRequestModel userRegistrationRequestModel = UserRegistrationRequestModel(
    userName: name,
    lastName:lastName,
    email: userEmail,
    password: userPassword,
    googleId: googleId,
    appleId: appleId,
    facebookId: facebookId
  );
  debugPrint("registration Request Body:${userRegistrationRequestModel.userName},${userRegistrationRequestModel.lastName},${userRegistrationRequestModel.email},${userRegistrationRequestModel.password},${userRegistrationRequestModel.googleId},${userRegistrationRequestModel.appleId},${userRegistrationRequestModel.facebookId}");

  try{
    var response = await Api.postRequestData(ApiEndPoints.registrationApi, userRegistrationRequestModel.toJson(), context);
    debugPrint("Registration Api Response: $response");
    UserRegistrationResponseModel userRegistrationResponseModel = UserRegistrationResponseModel.fromJson(jsonDecode(response));
    debugPrint("Registration Api Model Response: ${userRegistrationResponseModel.toJson()}");
    registrationProvider.setUserRegistration(userRegistrationResponseModel);
    return ApiResponse.completed(userRegistrationResponseModel);
  }catch (e){
    debugPrint("Registration Api Error Response: ${e.toString()}");
    return ApiResponse.error(e.toString());
  }
}

}