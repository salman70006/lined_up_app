import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/API/api_response.dart';
import 'package:com.zat.linedup/Models/AllReservationsModel/AllReservationsModel.dart';
import 'package:com.zat.linedup/Models/ReservationFilterRequestModel/ReservationFilterRequestModel.dart';
import 'package:com.zat.linedup/Models/ReservationFilterResponseModel/ReservationFilterResponseModel.dart';
import 'package:com.zat.linedup/Providers/AllReservationProvider/AllReservationProvider.dart';
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

  Future<ApiResponse<ReservationFilterResponseModel>?> applyFilter(BuildContext context,String type,String search,String startDate,String endDate)async{

    try{
      var filterReservationProvider = Provider.of<AllReservationProvider>(context,listen: false);
      ReservationFilterRequestModel requestModel = ReservationFilterRequestModel(
        type: type,
        search: search,
        startDate: startDate,
        endDate: endDate
      );
      debugPrint("filterRequest${requestModel.toJson()}");
      var response = await Api.postRequestData(ApiEndPoints.applyFilterOnReservation, requestModel.toJson(), context,sendToken: true);
      debugPrint("reservationFilterApiResponse$response");
      ReservationFilterResponseModel responseModel = ReservationFilterResponseModel.fromJson(jsonDecode(response));
      debugPrint("reservationFilterModelResponse:${responseModel.toJson()}");
      filterReservationProvider.filteredReservations(responseModel);
      return ApiResponse.completed(responseModel);
    }catch(e){
      debugPrint("reservationErrorResponse${e.toString()}");
      return ApiResponse.error(e.toString());

    }
  }
}