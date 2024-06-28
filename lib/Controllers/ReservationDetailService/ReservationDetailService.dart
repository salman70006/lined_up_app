

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:linedup_app/Models/ReservationsDetailResponseModel/ReservationsDetailResponseModel.dart';
import 'package:linedup_app/Providers/ReservationsDetailProvider/ReservationDetailProvider.dart';
import 'package:provider/provider.dart';

import '../../API/api.dart';
import '../../API/api_response.dart';

class ReservationDetailService{

  Future<ApiResponse<ReservationsDetailResponseModel>?> getAllReservationsDetail(BuildContext context,String detailId)async{

    var reservationDetailProvider = Provider.of<ReservationDetailProvider>(context,listen: false);
    try{
      var response = await Api.getRequestData("get-ticket-details?ticket_id=$detailId", context);
      debugPrint("All Reservation Detail Api Response: $response");
      ReservationsDetailResponseModel reservationsDetailResponseModel = ReservationsDetailResponseModel.fromJson(jsonDecode(response));
      debugPrint("All Reservation Detail Model Response: ${reservationsDetailResponseModel.toJson()}");
      reservationDetailProvider.reservationDetail(reservationsDetailResponseModel);
      return ApiResponse.completed(reservationsDetailResponseModel);
    }catch(e){
      debugPrint("Api Error: ${e.toString()}");
      return ApiResponse.error(e.toString());
    }
  }
}