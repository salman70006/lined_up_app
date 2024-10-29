import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/Models/HelpResponseModel/HelpResponseModel.dart';

class HelpProvider extends ChangeNotifier{
  HelpResponseModel? helpResponseModel;
  help(HelpResponseModel data){
    helpResponseModel = data;
    notifyListeners();
  }
}