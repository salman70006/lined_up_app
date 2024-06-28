import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:linedup_app/API/api.dart';
import 'package:linedup_app/API/api_response.dart';
import 'package:linedup_app/ApiEndPoints/ApiEndPoints.dart';
import 'package:linedup_app/Models/HelpRequestModel/HelpRequestModel.dart';
import 'package:linedup_app/Models/HelpResponseModel/HelpResponseModel.dart';
import 'package:linedup_app/Providers/HelpProvider/HelpProvider.dart';
import 'package:provider/provider.dart';

class HelpService {
  
  Future<ApiResponse<HelpResponseModel>?> sendHelp(BuildContext context,String title,description)async{
    var helpProvider = Provider.of<HelpProvider>(context,listen: false);
    HelpRequestModel helpRequestModel = HelpRequestModel(
      title: title,
      description: description
    );
    debugPrint("Help Request: ${helpRequestModel.title},${helpRequestModel.description}");
    try{
      var response = await Api.postRequestData(ApiEndPoints.sendSupport, helpRequestModel, context,sendToken: true);
      debugPrint("Help Api Response:$response");
      HelpResponseModel helpResponseModel = HelpResponseModel.fromJson(jsonDecode(response));
      debugPrint("Help Model Response:${helpResponseModel.toJson()}");
      helpProvider.help(helpResponseModel);
      return ApiResponse.completed(helpResponseModel);

    }catch(e){
      debugPrint("Help Error Response:${e.toString()}");
      return ApiResponse.error(e.toString());
    }
  }
}