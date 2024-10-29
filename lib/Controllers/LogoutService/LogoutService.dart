import 'dart:convert';

import 'package:com.zat.linedup/API/api.dart';
import 'package:com.zat.linedup/API/api_response.dart';
import 'package:com.zat.linedup/ApiEndPoints/ApiEndPoints.dart';
import 'package:com.zat.linedup/Models/LogoutResponseModel/LogoutResponseModel.dart';
import 'package:flutter/cupertino.dart';

class LogoutService{
  
  Future<ApiResponse<LogoutResponseModel>>? logoutUser(BuildContext context)async{
    
    try{
      var response = await Api.getRequestData(ApiEndPoints.logoutUser, context);
      debugPrint("LogoutApiResponse$response");
      LogoutResponseModel responseModel = LogoutResponseModel.fromJson(jsonDecode(response));
      debugPrint("LogoutUserApiModelResponse${responseModel.toJson()}");
      return ApiResponse.completed(responseModel);
    }catch(e){
      debugPrint("LogoutApiErrorResponse${e.toString()}");
      return ApiResponse.error(e.toString());
    }
  }
}