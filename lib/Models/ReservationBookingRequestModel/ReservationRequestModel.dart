class ReservationBookingRequestModel {
  String? barId;
  String? type;
  String? totalMembers;
  String? peakSlots;
  String? nonPeakSlots;
  dynamic eventId;
  dynamic reservationId;
  dynamic expressReservationId;
  double? netTotal;

  ReservationBookingRequestModel(
      {this.barId,
        this.type,
        this.totalMembers,
        this.peakSlots,
        this.nonPeakSlots,
        this.eventId,
        this.reservationId,
        this.expressReservationId,
        this.netTotal});

  ReservationBookingRequestModel.fromJson(Map<String, dynamic> json) {
    barId = json['bar_id'];
    type = json['type'];
    totalMembers = json['total_members'];
    peakSlots = json['peak_slots'];
    nonPeakSlots = json['non_peak_slots'];
    eventId = json['event_id'];
    reservationId = json['reservation_id'];
    expressReservationId = json['express_reservation_id'];
    netTotal = json['net_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bar_id'] = this.barId;
    data['type'] = this.type;
    data['total_members'] = this.totalMembers;
    data['peak_slots'] = this.peakSlots;
    data['non_peak_slots'] = this.nonPeakSlots;
    data['event_id'] = this.eventId;
    data['reservation_id'] = this.reservationId;
    data['express_reservation_id'] = this.expressReservationId;
    data['net_total'] = this.netTotal;
    return data;
  }
}
