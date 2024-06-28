class EnableUserLocationRequestModel {
  String? location;
  double? latitude;
  double? longitude;

  EnableUserLocationRequestModel(
      {this.location, this.latitude, this.longitude});

  EnableUserLocationRequestModel.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
