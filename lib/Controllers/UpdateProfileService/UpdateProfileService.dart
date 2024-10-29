import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/API/api.dart';
import 'package:com.zat.linedup/API/api_response.dart';
import 'package:com.zat.linedup/ApiEndPoints/ApiEndPoints.dart';
import 'package:com.zat.linedup/Models/UpdateProfileResponseModel/UpdateProfileResponseModel.dart';
import 'package:provider/provider.dart';

import '../../Providers/EditProfileProvider/EditProfileProvider.dart';

class UpdateProfileService {

  Future<ApiResponse<UpdateProfileResponseModel>?> updateProfile(BuildContext context, String userName,email,password,dob,gender)async{
    var updateUserProvider = Provider.of<EditProfileProvider>(context,listen: false);
    var profilePath;
    if(updateUserProvider.file?.path!=null){
    profilePath = await MultipartFile.fromFile( updateUserProvider.file!.path);

    }
    // print("profilePath :${profilePath.filename}");
    FormData formData = FormData.fromMap({
      "user_name":userName,
      "email":email,
      "password":password,
      "dob":dob,
      "gender":gender,
      "profile_image":profilePath
    });
    print(formData.fields);
    try{
      var response = await Api.postRequestData(ApiEndPoints.updateProfile, formData, context,sendToken: true,formData: true);
      print("UpdateProfileApiResponse:$response");
      UpdateProfileResponseModel updateProfileResponseModel = UpdateProfileResponseModel.fromJson(jsonDecode(response));
      print("UpdateProfileModelResponse:${updateProfileResponseModel.toJson()}");
      updateUserProvider.updateProfile(updateProfileResponseModel);
      return ApiResponse.completed(updateProfileResponseModel);
    }catch (e){
      print("UpdateApiError: ${e.toString()}");
      return ApiResponse.error(e.toString());
    }
  }
}