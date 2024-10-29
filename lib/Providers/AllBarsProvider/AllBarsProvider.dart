import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/Models/AllBarsResponseModel/AllBarsResponseModel.dart';
import 'package:com.zat.linedup/Models/HomeSearchResponseModel/HomeSearchResponseModel.dart';

class AllBarsProvider extends ChangeNotifier {
  AllBarsResponseModel? allBarsResponseModel;
  HomeSearchResponseModel? homeSearchResponseModel;

  allBars(AllBarsResponseModel data) async {
    allBarsResponseModel = data;
    notifyListeners();
  }

  homeSearch(HomeSearchResponseModel data) {
    homeSearchResponseModel = data;
    notifyListeners();
  }
}
