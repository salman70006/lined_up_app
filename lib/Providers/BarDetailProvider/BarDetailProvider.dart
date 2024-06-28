import 'package:flutter/cupertino.dart';
import 'package:linedup_app/Models/BarDetailsResponseModel/BarDetailsResponseModel.dart';
import 'package:linedup_app/Models/ReservationBookingResponseModel/ReservationBookingResponseModel.dart';

class BarDetailProvider extends ChangeNotifier{

  BarDetailsResponseModel? barDetailsResponseModel;

  ReservationBookingResponseModel? reservationBookingResponseModel;
  bool? isCheck=false;
  barDetails(BarDetailsResponseModel data){
    barDetailsResponseModel = data;
    notifyListeners();
  }

  bookReservation(ReservationBookingResponseModel data){

    reservationBookingResponseModel = data;
    notifyListeners();
  }
  setValue(value){
    isCheck = value;
    debugPrint(
        "Value is::::$value"
    );
    notifyListeners();
  }
}