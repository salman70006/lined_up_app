import 'package:flutter/cupertino.dart';

import '../../Models/GetAllNotificationsResponseModel/GetAllNotificationsResponseModel.dart';

class NotificationsProvider extends ChangeNotifier {
  GetAllNotificationsResponseModel? getAllNotificationsResponseModel;

  notifications(GetAllNotificationsResponseModel data) {
    getAllNotificationsResponseModel = data;
    notifyListeners();
  }
}
