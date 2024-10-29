import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/Models/UserProfileResponseModel/UserProfileResponseModel.dart';

class UserProfileProvider extends ChangeNotifier{

  UserProfileResponseModel? userProfileResponseModel;
  userProfile(UserProfileResponseModel data){

    userProfileResponseModel = data;
    notifyListeners();
  }
}