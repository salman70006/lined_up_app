import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:linedup_app/API/api_response.dart';
import 'package:linedup_app/Models/AllFavouritesResponseModel/AllFavouritesResponseModel.dart';
import 'package:linedup_app/Models/FavoruiteToggleResponseModel/FavoruiteToggleResponseModel.dart';
import 'package:linedup_app/Providers/AllFavouritesProvider/AllFavouritesProvider.dart';
import 'package:provider/provider.dart';

import '../../API/api.dart';
import '../../ApiEndPoints/ApiEndPoints.dart';

class AllFavoriteService{

  Future<ApiResponse<AllFavouriteResponseModel>?> fetchFavourites(BuildContext context)async{
    var favouritesProvider = Provider.of<AllFavouritesProvider>(context,listen: false);
    try{
      var response = await Api.getRequestData(ApiEndPoints.AllFavourites, context);
      debugPrint("All favourites Api Response: $response");
      AllFavouriteResponseModel allFavouriteResponseModel = AllFavouriteResponseModel.fromJson(jsonDecode(response));
      debugPrint("All favourites Model Response: ${allFavouriteResponseModel.toJson()}");
      favouritesProvider.favourites(allFavouriteResponseModel);
      return ApiResponse.completed(allFavouriteResponseModel);
    }catch(e){
      debugPrint("Api Error: ${e.toString()}");
      return ApiResponse.error(e.toString());
    }
  }


Future<ApiResponse<FavouriteToggleResponseModel>?> toggle(BuildContext context,barId)async{

  var favouritesProvider = Provider.of<AllFavouritesProvider>(context,listen: false);
  try{
    var response = await Api.getRequestData("add-to-wishlist?bar_id=$barId", context);
    debugPrint("toggle Api Response: $response");
    FavouriteToggleResponseModel toggleResponseModel = FavouriteToggleResponseModel.fromJson(jsonDecode(response));
    debugPrint("toggle favourites Model Response: ${toggleResponseModel.toJson()}");
    favouritesProvider.toggle(toggleResponseModel);
    return ApiResponse.completed(toggleResponseModel);
  }catch(e){
    debugPrint("Api Error: ${e.toString()}");
    return ApiResponse.error(e.toString());
  }
}
}