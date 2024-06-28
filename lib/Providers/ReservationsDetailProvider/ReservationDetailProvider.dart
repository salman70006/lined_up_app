import 'package:flutter/cupertino.dart';
import 'package:linedup_app/Models/GiveReviewResponseModel/GiveReviewResponseModel.dart';
import 'package:linedup_app/Models/RedeemTicketResponseModel/RedeemTicketResponseModel.dart';
import 'package:linedup_app/Models/ReservationsDetailResponseModel/ReservationsDetailResponseModel.dart';

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