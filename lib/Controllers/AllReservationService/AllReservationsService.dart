import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:linedup_app/API/api_response.dart';
import 'package:linedup_app/Models/AllReservationsModel/AllReservationsModel.dart';
import 'package:linedup_app/Providers/AllReservationProvider/AllReservationProvider.dart';
import 'package:provider/provider.dart';

import '../../API/api.dart';
import '../../ApiEndPoints/ApiEndPoints.dart';

class AllReservationsService{

  Future<ApiResponse<AllReservationsModel>?> getAllReservations(BuildContext context)async{

    var reservationProvider = Provider.of<AllReservationProvider>(context,listen: false);
    try{
      var response = await Api.getRequestData(ApiEndPoints.allReservation, context);
      debugPrint("All Reservation Api Response: $response");
      AllReservationsModel allReservationsModel = AllReservationsModel.fromJson(jsonDecode(response));
      debugPrint("All Reservation Model Response: ${allReservationsModel.toJson()}");
      reservationProvider.allReservation(allReservationsModel);
      return ApiResponse.completed(allReservationsModel);
    }catch(e){
      debugPrint("Api Error: ${e.toString()}");
      return ApiResponse.error(e.toString());
    }
  }
}