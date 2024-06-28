import 'package:flutter/cupertino.dart';
import 'package:linedup_app/Models/AllUsersResponseModel/AllUsersResponseModel.dart';

class AllUsersProvider extends ChangeNotifier{
  AllUsersResponseModel? allUsersResponseModel;
  int? selectedUserId;
  allUsers(AllUsersResponseModel data){
    allUsersResponseModel = data;
    notifyListeners();
  }
  UserId(int userId){
    selectedUserId = userId;
    notifyListeners();
  }
}