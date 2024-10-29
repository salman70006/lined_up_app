class ReservationFilterRequestModel {
  String? type;
  String? search;
  String? startDate;
  String? endDate;

  ReservationFilterRequestModel(
      {this.type, this.search, this.startDate, this.endDate});

  ReservationFilterRequestModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    search = json['search'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['search'] = this.search;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}
