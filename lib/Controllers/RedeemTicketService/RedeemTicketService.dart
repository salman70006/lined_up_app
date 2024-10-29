import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/API/api.dart';
import 'package:com.zat.linedup/API/api_response.dart';
import 'package:com.zat.linedup/ApiEndPoints/ApiEndPoints.dart';
import 'package:com.zat.linedup/Models/RedeemTicketRequestModel/RedeemTicketRequestModel.dart';
import 'package:com.zat.linedup/Models/RedeemTicketResponseModel/RedeemTicketResponseModel.dart';
import 'package:com.zat.linedup/Providers/ReservationsDetailProvider/ReservationDetailProvider.dart';
import 'package:provider/provider.dart';

class RedeemTicketService {
  
  Future<ApiResponse<RedeemTicketResponseModel>?> redeemTicket(BuildContext context,String ticketId)async{
    var redeemTicket = Provider.of<ReservationDetailProvider>(context,listen: false);
    RedeemTicketRequestModel redeemTicketRequestModel = RedeemTicketRequestModel(
      ticketId: ticketId
    );
    debugPrint("Redeem Ticket Request ${redeemTicketRequestModel.ticketId}");
    try{
      var response = await Api.postRequestData(ApiEndPoints.redeemTicket, redeemTicketRequestModel.toJson(), context,sendToken: true);
      debugPrint("Redeem Ticket Response $response}");
      RedeemTicketResponseModel redeemTicketResponseModel = RedeemTicketResponseModel.fromJson(jsonDecode(response));
      debugPrint("Redeem Ticket Model Response ${redeemTicketResponseModel.toJson()}");
      redeemTicket.redeem(redeemTicketResponseModel);
      return ApiResponse.completed(redeemTicketResponseModel);

    }catch (e){
      debugPrint("Redeem Ticket Api Error: ${redeemTicketRequestModel.ticketId}");
      
      return ApiResponse.error(e.toString());
    }
  }
}