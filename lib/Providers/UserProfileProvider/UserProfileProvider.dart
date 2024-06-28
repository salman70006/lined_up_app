import 'package:flutter/cupertino.dart';
import 'package:linedup_app/Models/UserProfileResponseModel/UserProfileResponseModel.dart';

class UserProfileProvider extends ChangeNotifier{

  UserProfileResponseModel? userProfileResponseModel;
  userProfile(UserProfileResponseModel data){

    userProfileResponseModel = data;
    notifyListeners();
  }
}