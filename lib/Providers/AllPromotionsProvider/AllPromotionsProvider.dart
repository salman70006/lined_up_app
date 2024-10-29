import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/Models/GetAllPromotionsResponseModel/GetAllPromotionsResponseModel.dart';

class AllPromotionsProvider extends ChangeNotifier{

  GetBarPromotionsResponseModel? getBarPromotionsResponseModel;
  getBarPromotions(GetBarPromotionsResponseModel data){
    getBarPromotionsResponseModel = data;
    notifyListeners();
  }
}