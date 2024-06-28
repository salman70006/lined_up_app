import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:linedup_app/API/api.dart';
import 'package:linedup_app/API/api_response.dart';
import 'package:linedup_app/ApiEndPoints/ApiEndPoints.dart';
import 'package:linedup_app/Models/AllUsersResponseModel/AllUsersResponseModel.dart';
import 'package:linedup_app/Providers/AllUsersProvider/AllUsersProvider.dart';
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