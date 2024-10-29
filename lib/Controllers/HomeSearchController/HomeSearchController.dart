import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/API/api.dart';
import 'package:com.zat.linedup/API/api_response.dart';
import 'package:com.zat.linedup/ApiEndPoints/ApiEndPoints.dart';
import 'package:com.zat.linedup/Models/HomeSearchRequestModel/HomeSearchRequestModel.dart';
import 'package:com.zat.linedup/Models/HomeSearchResponseModel/HomeSearchResponseModel.dart';
import 'package:com.zat.linedup/Providers/AllBarsProvider/AllBarsProvider.dart';
import 'package:provider/provider.dart';

class HomeSearchService {
  
  Future<ApiResponse<HomeSearchResponseModel>?> search(BuildContext context,String search)async{
    try{
      
      var searchProvider = Provider.of<AllBarsProvider>(context,listen: false);
      HomeSearchRequestModel homeSearchRequestModel = HomeSearchRequestModel(
        search: search
      );
      var response = await Api.postRequestData(ApiEndPoints.searchBars, homeSearchRequestModel.toJson(), context,sendToken: true);
      debugPrint("searchApiResponse:$response");
      HomeSearchResponseModel homeSearchResponseModel = HomeSearchResponseModel.fromJson(jsonDecode(response));
      debugPrint("searchApiModerResponse:${homeSearchResponseModel.toJson()}");
      searchProvider.homeSearch(homeSearchResponseModel);
      return ApiResponse.completed(homeSearchResponseModel);
    }catch (e){
      debugPrint("searchApiErrorResponse:${e.toString()}");
      return ApiResponse.error(e.toString());
    }
  }
}