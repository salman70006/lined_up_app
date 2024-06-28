import 'package:flutter/cupertino.dart';
import 'package:linedup_app/Models/TransferTicketResponseModel/TransferTicketResponseModel.dart';

class TransferTicketProvider extends ChangeNotifier{
  TransferTicketResponseModel? transferTicketResponseModel;

  transferTicket(TransferTicketResponseModel data){

    transferTicketResponseModel = data;
    notifyListeners();
  }

}