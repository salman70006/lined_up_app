import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:linedup_app/Models/GetAllPromotionsResponseModel/GetAllPromotionsResponseModel.dart';
import 'package:linedup_app/Providers/AllPromotionsProvider/AllPromotionsProvider.dart';
import 'package:provider/provider.dart';

import '../../API/api.dart';
import '../../API/api_response.dart';

class BarsPromotionService{


  Future<ApiResponse<GetBarPromotionsResponseModel>?> fetchPromotions(BuildContext context,String barId)async{

    var promotionProvider = Provider.of<AllPromotionsProvider>(context,listen: false);

    try{
      var response = await Api.getRequestData("get-bar-promotions?bar_id=$barId", context);
      debugPrint("All Bars Api Response: $response");
      GetBarPromotionsResponseModel getBarPromotionsResponseModel = GetBarPromotionsResponseModel.fromJson(jsonDecode(response));
      debugPrint("All Bars Model Response: ${getBarPromotionsResponseModel.toJson()}");
      promotionProvider.getBarPromotions(getBarPromotionsResponseModel);
      return ApiResponse.completed(getBarPromotionsResponseModel);
    }catch(e){
      debugPrint("Api Error: ${e.toString()}");
      return ApiResponse.error(e.toString());
    }
  }
}