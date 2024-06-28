import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:linedup_app/API/api.dart';
import 'package:linedup_app/API/api_response.dart';
import 'package:linedup_app/ApiEndPoints/ApiEndPoints.dart';
import 'package:linedup_app/Models/RedeemTicketRequestModel/RedeemTicketRequestModel.dart';
import 'package:linedup_app/Models/RedeemTicketResponseModel/RedeemTicketResponseModel.dart';
import 'package:linedup_app/Providers/ReservationsDetailProvider/ReservationDetailProvider.dart';
import 'package:provider/provider.dart';

class RedeemTicketService {
  
  Future<ApiResponse<RedeemTicketResponseModel>?> redeemTicket(BuildContext context,String ticketId)async{
    var redeemTicket = Provider.of<ReservationDetailProvider>(context,listen: false);
    RedeemTicketRequestModel redeemTicketRequestModel = RedeemTicketRequestModel(
      ticketId: ticketId
    );
    debugPrint("Redeem Ticket Request ${redeemTicketRequestModel.ticketId}");
    try{
      var response = await Api.postRequestData(ApiEndPoints.redeemTicket, redeemTicketRequestModel, context,sendToken: true);
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