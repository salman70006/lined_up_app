class TransferTicketRequestModel {
  String? ticketId;
  String? transferToUserId;

  TransferTicketRequestModel({this.ticketId, this.transferToUserId});

  TransferTicketRequestModel.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    transferToUserId = json['transfer_to_user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['transfer_to_user_id'] = this.transferToUserId;
    return data;
  }
}
