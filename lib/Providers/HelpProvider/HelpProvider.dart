import 'package:flutter/cupertino.dart';
import 'package:linedup_app/Models/HelpResponseModel/HelpResponseModel.dart';

class HelpProvider extends ChangeNotifier{
  HelpResponseModel? helpResponseModel;
  help(HelpResponseModel data){
    helpResponseModel = data;
    notifyListeners();
  }
}