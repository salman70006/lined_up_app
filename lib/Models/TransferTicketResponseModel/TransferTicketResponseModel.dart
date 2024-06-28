class TransferTicketResponseModel {
  bool? success;
  String? message;
  Data? data;

  TransferTicketResponseModel({this.success, this.message, this.data});

  TransferTicketResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? transferFromId;
  String? ticketId;
  String? transferToId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.transferFromId,
        this.ticketId,
        this.transferToId,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    transferFromId = json['transfer_from_id'];
    ticketId = json['ticket_id'];
    transferToId = json['transfer_to_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transfer_from_id'] = this.transferFromId;
    data['ticket_id'] = this.ticketId;
    data['transfer_to_id'] = this.transferToId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
