
import 'package:flutter/cupertino.dart';
import 'package:linedup_app/Models/AllFavouritesResponseModel/AllFavouritesResponseModel.dart';
import 'package:linedup_app/Models/FavoruiteToggleResponseModel/FavoruiteToggleResponseModel.dart';

class AllFavouritesProvider extends ChangeNotifier{
  AllFavouriteResponseModel? allFavouriteResponseModel;
  FavouriteToggleResponseModel? favouriteToggleResponseModel;
  favourites(AllFavouriteResponseModel data){
    allFavouriteResponseModel = data;
    notifyListeners();
  }
  toggle(FavouriteToggleResponseModel data){
    favouriteToggleResponseModel = data;
    notifyListeners();
  }
}