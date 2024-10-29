import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/API/api.dart';
import 'package:com.zat.linedup/API/api_response.dart';
import 'package:com.zat.linedup/ApiEndPoints/ApiEndPoints.dart';
import 'package:com.zat.linedup/Models/BarDetailsResponseModel/BarDetailsResponseModel.dart';
import 'package:com.zat.linedup/Models/ReservationBookingRequestModel/ReservationRequestModel.dart';
import 'package:com.zat.linedup/Models/ReservationBookingResponseModel/ReservationBookingResponseModel.dart';
import 'package:com.zat.linedup/Providers/BarDetailProvider/BarDetailProvider.dart';
import 'package:provider/provider.dart';

class BarDetailService{
  
  Future<ApiResponse<BarDetailsResponseModel>?> barDetail(BuildContext context,barId)async{
    
    var barDetailProvider = Provider.of<BarDetailProvider>(context,listen: false);
    try{
      var response = await Api.getRequestData("get-bar-detail?bar_id=$barId", context);
      debugPrint("Bar Detail Api Response:$response");
      BarDetailsResponseModel barDetailsResponseModel = BarDetailsResponseModel.fromJson(jsonDecode(response));
      debugPrint("Bar detail model response:${barDetailsResponseModel.toJson()}");
      barDetailProvider.barDetails(barDetailsResponseModel);
      return ApiResponse.completed(barDetailsResponseModel);
    }catch (e){
      debugPrint("Bar detail api error:${e.toString()}");
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<ReservationBookingResponseModel>?> reservationBooking(BuildContext context,dynamic reservationId,dynamic eventId,dynamic expressReservationId,String totalMember,String barId,String type,dynamic peakSlots,dynamic nonPeakSlots,double netTotal)async{
    var reservationBookingProvider = Provider.of<BarDetailProvider>(context,listen: false);
    
    ReservationBookingRequestModel requestModel = ReservationBookingRequestModel(
      barId: barId,
      type: type,
      totalMembers: totalMember,
      peakSlots: peakSlots,
      nonPeakSlots: nonPeakSlots,
      reservationId: reservationId,
      eventId: eventId,
      expressReservationId: expressReservationId,
      netTotal: netTotal
    );
    print(jsonEncode(requestModel));
    try{
      var response = await Api.postRequestData(ApiEndPoints.applyForReservation, requestModel.toJson(), context,sendToken: true);
      print("Apply reservation api response:$response");
      ReservationBookingResponseModel reservationBookingResponseModel = ReservationBookingResponseModel.fromJson(jsonDecode(response));
      print("Apply reservation model response ${reservationBookingResponseModel.toJson()}");
      reservationBookingProvider.bookReservation(reservationBookingResponseModel);
      return ApiResponse.completed(reservationBookingResponseModel);
    }catch (e){
      print("Apply reservation model response ${e.toString()}");

      return ApiResponse.error(e.toString());
    }
    
  }
}