import 'package:flutter/cupertino.dart';

import '../../Models/BarEventDetailResponseModel/BarEventDetailResponseModel.dart';

class EventDetailProvider extends ChangeNotifier{

  BarEventDetailResponseModel? barEventDetailResponseModel;
  eventsDetail(BarEventDetailResponseModel data){

    barEventDetailResponseModel = data;
    notifyListeners();
  }
}