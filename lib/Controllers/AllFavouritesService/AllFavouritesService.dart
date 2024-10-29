import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/API/api_response.dart';
import 'package:com.zat.linedup/Models/AllFavouritesResponseModel/AllFavouritesResponseModel.dart';
import 'package:com.zat.linedup/Models/FavoruiteToggleResponseModel/FavoruiteToggleResponseModel.dart';
import 'package:com.zat.linedup/Models/WishListSearchRequestModel/WishListSearchRequestModel.dart';
import 'package:com.zat.linedup/Models/WishListSearchResponseModel/WishListSearchResponseModel.dart';
import 'package:com.zat.linedup/Providers/AllFavouritesProvider/AllFavouritesProvider.dart';
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

Future<ApiResponse<WishListSearchResponseModel>?> searchFromWishList(BuildContext context,String searchFromWishList)async{
    
    try{
      var searchWishListProvider = Provider.of<AllFavouritesProvider>(context,listen: false);
      WishListSearchRequestModel wishListSearchRequestModel = WishListSearchRequestModel(
        search: searchFromWishList
      );
      debugPrint("searchFromFavouritesRequest${wishListSearchRequestModel.toJson()}");
      var response = await Api.postRequestData(ApiEndPoints.searchOnWishList, wishListSearchRequestModel.toJson(), context,sendToken: true);
      debugPrint("searOnWishListApiResponse$response");
      WishListSearchResponseModel wishListSearchResponseModel = WishListSearchResponseModel.fromJson(jsonDecode(response));
      debugPrint("wishListModelResponse:${wishListSearchResponseModel.toJson()}");
      searchWishListProvider.searchFromWishList(wishListSearchResponseModel);
      return ApiResponse.completed(wishListSearchResponseModel);
    }catch (e){
      debugPrint("searchOnWishListApiErrorResponse::${e.toString()}");
      return ApiResponse.error(e.toString());
    }
}
}