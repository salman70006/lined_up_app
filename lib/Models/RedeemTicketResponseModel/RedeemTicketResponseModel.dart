class RedeemTicketResponseModel {
  bool? success;
  String? message;
  Data? data;

  RedeemTicketResponseModel({this.success, this.message, this.data});

  RedeemTicketResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? userId;
  String? barId;
  String? barOwnerId;
  String? ticketNumber;
  String? eventId;
  String? reservationId;
  String? expressReservationId;
  String? peakSlotIds;
  String? nonPeakSlotIds;
  String? type;
  String? totalMembers;
  String? netTotal;
  String? paymentStatus;
  String? isRedeemed;
  String? createdAt;
  String? updatedAt;
  bool? isTransferred;

  Data(
      {this.id,
        this.userId,
        this.barId,
        this.barOwnerId,
        this.ticketNumber,
        this.eventId,
        this.reservationId,
        this.expressReservationId,
        this.peakSlotIds,
        this.nonPeakSlotIds,
        this.type,
        this.totalMembers,
        this.netTotal,
        this.paymentStatus,
        this.isRedeemed,
        this.createdAt,
        this.updatedAt,
        this.isTransferred});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    barId = json['bar_id'];
    barOwnerId = json['bar_owner_id'];
    ticketNumber = json['ticket_number'];
    eventId = json['event_id'];
    reservationId = json['reservation_id'];
    expressReservationId = json['express_reservation_id'];
    peakSlotIds = json['peak_slot_ids'];
    nonPeakSlotIds = json['non_peak_slot_ids'];
    type = json['type'];
    totalMembers = json['total_members'];
    netTotal = json['net_total'];
    paymentStatus = json['payment_status'];
    isRedeemed = json['is_redeemed'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isTransferred = json['is_transferred'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['bar_id'] = this.barId;
    data['bar_owner_id'] = this.barOwnerId;
    data['ticket_number'] = this.ticketNumber;
    data['event_id'] = this.eventId;
    data['reservation_id'] = this.reservationId;
    data['express_reservation_id'] = this.expressReservationId;
    data['peak_slot_ids'] = this.peakSlotIds;
    data['non_peak_slot_ids'] = this.nonPeakSlotIds;
    data['type'] = this.type;
    data['total_members'] = this.totalMembers;
    data['net_total'] = this.netTotal;
    data['payment_status'] = this.paymentStatus;
    data['is_redeemed'] = this.isRedeemed;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_transferred'] = this.isTransferred;
    return data;
  }
}
