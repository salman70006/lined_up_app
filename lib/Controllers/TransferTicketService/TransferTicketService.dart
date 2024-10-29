import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/API/api.dart';
import 'package:com.zat.linedup/API/api_response.dart';
import 'package:com.zat.linedup/ApiEndPoints/ApiEndPoints.dart';
import 'package:com.zat.linedup/Models/TransferTicketRequestModel/TransferTicketRequestModel.dart';
import 'package:com.zat.linedup/Models/TransferTicketResponseModel/TransferTicketResponseModel.dart';
import 'package:com.zat.linedup/Providers/TransferTicketProvider/TransferTicketProvider.dart';
import 'package:provider/provider.dart';

class TransferTicketService{

  Future<ApiResponse<TransferTicketResponseModel>?> transferTicket(BuildContext context,String ticketId,userId)async{

    var transferTicketProvider = Provider.of<TransferTicketProvider>(context,listen: false);
    TransferTicketRequestModel transferTicketRequestModel = TransferTicketRequestModel(
      ticketId: ticketId,
      transferToUserId: userId,
    );
    debugPrint("request to transfer ticket:${transferTicketRequestModel.ticketId},${transferTicketRequestModel.transferToUserId}");
    
    try{
      var response = await Api.postRequestData(ApiEndPoints.transferTicket, transferTicketRequestModel.toJson(), context,sendToken: true);
      debugPrint("transfer ticket api response:$response");
      TransferTicketResponseModel ticketResponseModel = TransferTicketResponseModel.fromJson(jsonDecode(response));
      debugPrint("transfer ticket model response:${ticketResponseModel.toJson()}");
      transferTicketProvider.transferTicket(ticketResponseModel);
      return ApiResponse.completed(ticketResponseModel);

    }catch (e){
      debugPrint("transfer ticket api error response:${e.toString()}");
      return ApiResponse.error(e.toString());
    }
  }
}