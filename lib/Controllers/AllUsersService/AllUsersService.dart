import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/API/api.dart';
import 'package:com.zat.linedup/API/api_response.dart';
import 'package:com.zat.linedup/ApiEndPoints/ApiEndPoints.dart';
import 'package:com.zat.linedup/Models/AllUsersResponseModel/AllUsersResponseModel.dart';
import 'package:com.zat.linedup/Providers/AllUsersProvider/AllUsersProvider.dart';
import 'package:provider/provider.dart';

class AllUsersService{

  Future<ApiResponse<AllUsersResponseModel>?> getAllUsers(BuildContext context)async{
    var usersProvider = Provider.of<AllUsersProvider>(context,listen: false);
    try{
      var response = await Api.getRequestData(ApiEndPoints.allUsers, context);
      debugPrint("Transfer Ticket Api  Response:$response");
      AllUsersResponseModel allUsersResponseModel = AllUsersResponseModel.fromJson(jsonDecode(response));
      debugPrint("Transfer Ticket Api Model Response:${allUsersResponseModel.toJson()}");
      usersProvider.allUsers(allUsersResponseModel);
      return ApiResponse.completed(allUsersResponseModel);


    }catch (e){
      debugPrint("Transfer Ticket Api Error Response:${e.toString()}");
      return ApiResponse.error(e.toString());
    }
  }
}