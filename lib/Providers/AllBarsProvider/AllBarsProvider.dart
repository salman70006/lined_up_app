import 'package:flutter/cupertino.dart';
import 'package:linedup_app/Models/AllBarsResponseModel/AllBarsResponseModel.dart';

class AllBarsProvider extends ChangeNotifier{

  AllBarsResponseModel? allBarsResponseModel;
  allBars(AllBarsResponseModel data)async{
    allBarsResponseModel = data;
    notifyListeners();
  }
}