import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:linedup_app/API/api.dart';
import 'package:linedup_app/API/api_response.dart';
import 'package:linedup_app/ApiEndPoints/ApiEndPoints.dart';
import 'package:linedup_app/Models/UserProfileResponseModel/UserProfileResponseModel.dart';
import 'package:linedup_app/Providers/UserProfileProvider/UserProfileProvider.dart';
import 'package:provider/provider.dart';

class UserProfileService {

  Future<ApiResponse<UserProfileResponseModel>?> getUserProfile(BuildContext context)async{
    var userProfileProvider = Provider.of<UserProfileProvider>(context,listen: false);
    try{
      var response = await Api.getRequestData(ApiEndPoints.userProfile, context);
      debugPrint("User Profile APi Response:$response");

      UserProfileResponseModel userProfileResponseModel = UserProfileResponseModel.fromJson(jsonDecode(response));
      debugPrint("User Profile APi Model Response:${userProfileResponseModel.toJson()}");
      userProfileProvider.userProfile(userProfileResponseModel);
      return ApiResponse.completed(userProfileResponseModel);
    }catch (e){
      debugPrint("User Profile APi Error Response:${e.toString()}");
      return ApiResponse.error(e.toString());
    }
  }
}