
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:linedup_app/API/api.dart';
import 'package:linedup_app/API/api_response.dart';
import 'package:linedup_app/ApiEndPoints/ApiEndPoints.dart';
import 'package:linedup_app/Models/AuthModels/UserRegistrationRequestModel/UserRegistrationRequestModel.dart';
import 'package:linedup_app/Models/AuthModels/UserRegistrationResponseModel/UserRegistrationResponseModel.dart';
import 'package:linedup_app/Providers/UserRegistrationProvider/UserRegistrationProvider.dart';
import 'package:provider/provider.dart';

class UserRegistrationService {
Future<ApiResponse<UserRegistrationResponseModel>?>  userRegistration(BuildContext context,String name,userEmail,userPassword,googleId,appleId,facebookId)async{
  var registrationProvider = Provider.of<UserRegistrationProvider>(context,listen: false);
  UserRegistrationRequestModel userRegistrationRequestModel = UserRegistrationRequestModel(
    userName: name,
    email: userEmail,
    password: userPassword,
    googleId: googleId,
    appleId: appleId,
    facebookId: facebookId
  );
  debugPrint("registration Request Body:${userRegistrationRequestModel.userName},${userRegistrationRequestModel.email},${userRegistrationRequestModel.password},${userRegistrationRequestModel.googleId},${userRegistrationRequestModel.appleId},${userRegistrationRequestModel.facebookId}");

  try{
    var response = await Api.postRequestData(ApiEndPoints.registrationApi, userRegistrationRequestModel, context);
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