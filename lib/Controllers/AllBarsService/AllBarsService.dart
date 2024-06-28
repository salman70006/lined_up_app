import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:linedup_app/API/api.dart';
import 'package:linedup_app/API/api_response.dart';
import 'package:linedup_app/ApiEndPoints/ApiEndPoints.dart';
import 'package:linedup_app/Models/AllBarsResponseModel/AllBarsResponseModel.dart';
import 'package:linedup_app/Providers/AllBarsProvider/AllBarsProvider.dart';
import 'package:provider/provider.dart';

class AllBarsService{

  Future<ApiResponse<AllBarsResponseModel>?> fetchAllBars(BuildContext context)async{

    var barsProvider = Provider.of<AllBarsProvider>(context,listen: false);

    try{
      var response = await Api.getRequestData(ApiEndPoints.getAllBars, context);
      debugPrint("All Bars Api Response: $response");
      AllBarsResponseModel allBarsResponseModel = AllBarsResponseModel.fromJson(jsonDecode(response));
      debugPrint("All Bars Model Response: ${allBarsResponseModel.toJson()}");
      barsProvider.allBars(allBarsResponseModel);
     return ApiResponse.completed(allBarsResponseModel);
    }catch(e){
      debugPrint("Api Error: ${e.toString()}");
      return ApiResponse.error(e.toString());
    }
  }
}