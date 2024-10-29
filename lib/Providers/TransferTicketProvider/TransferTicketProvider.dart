import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/Models/TransferTicketResponseModel/TransferTicketResponseModel.dart';

class TransferTicketProvider extends ChangeNotifier{
  TransferTicketResponseModel? transferTicketResponseModel;

  transferTicket(TransferTicketResponseModel data){

    transferTicketResponseModel = data;
    notifyListeners();
  }

}