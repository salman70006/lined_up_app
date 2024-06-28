import 'package:flutter/cupertino.dart';
import 'package:linedup_app/Models/AllReservationsModel/AllReservationsModel.dart';

class AllReservationProvider extends ChangeNotifier{
  AllReservationsModel? allReservationsModel;
  allReservation(AllReservationsModel data){
    allReservationsModel = data;
    notifyListeners();
  }

}