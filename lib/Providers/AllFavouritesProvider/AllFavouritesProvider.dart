
import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/Models/AllFavouritesResponseModel/AllFavouritesResponseModel.dart';
import 'package:com.zat.linedup/Models/FavoruiteToggleResponseModel/FavoruiteToggleResponseModel.dart';
import 'package:com.zat.linedup/Models/WishListSearchResponseModel/WishListSearchResponseModel.dart';

class AllFavouritesProvider extends ChangeNotifier{
  AllFavouriteResponseModel? allFavouriteResponseModel;
  FavouriteToggleResponseModel? favouriteToggleResponseModel;
  WishListSearchResponseModel? wishListSearchResponseModel;
  favourites(AllFavouriteResponseModel data){
    allFavouriteResponseModel = data;
    notifyListeners();
  }
  toggle(FavouriteToggleResponseModel data){
    favouriteToggleResponseModel = data;
    notifyListeners();
  }
  searchFromWishList(WishListSearchResponseModel data){
    wishListSearchResponseModel = data;
    notifyListeners();
  }
}