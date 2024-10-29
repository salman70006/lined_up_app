import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/Models/GiveReviewResponseModel/GiveReviewResponseModel.dart';
import 'package:com.zat.linedup/Models/RedeemTicketResponseModel/RedeemTicketResponseModel.dart';
import 'package:com.zat.linedup/Models/ReservationsDetailResponseModel/ReservationsDetailResponseModel.dart';

class ReservationDetailProvider extends ChangeNotifier{

  ReservationsDetailResponseModel? reservationsDetailResponseModel;
  GiveReviewResponseModel? giveReviewResponseModel;
  RedeemTicketResponseModel? redeemTicketResponseModel;
  reservationDetail(ReservationsDetailResponseModel data){

    reservationsDetailResponseModel = data;
    notifyListeners();
  }

  review(GiveReviewResponseModel data){
    giveReviewResponseModel = data;
    notifyListeners();
  }

  redeem(RedeemTicketResponseModel data){
    redeemTicketResponseModel = data;
    notifyListeners();
  }
}