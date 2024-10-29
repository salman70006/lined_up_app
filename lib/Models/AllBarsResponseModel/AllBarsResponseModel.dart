class AllBarsResponseModel {
  bool? success;
  String? message;
  List<BarData>? barData;

  AllBarsResponseModel({this.success, this.message, this.barData});

  AllBarsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      barData = <BarData>[];
      json['data'].forEach((v) {
        barData!.add(new BarData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.barData != null) {
      data['data'] = this.barData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BarData {
  int? id;
  int? barOwnerId;
  String? venue;
  String? longitude;
  String? latitude;
  List<dynamic>? barInfo;
  String? aboutUs;
  String? address;
  String? startTime;
  String? endTime;
  bool? havePromotion;
  bool? isLiked;
  String? coverImage;

  BarData(
      {this.id,
        this.barOwnerId,
        this.venue,
        this.longitude,
        this.latitude,
        this.barInfo,
        this.aboutUs,
        this.address,
        this.startTime,
        this.endTime,
        this.havePromotion,
        this.isLiked,
        this.coverImage});

  BarData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barOwnerId = json['bar_owner_id'];
    venue = json['venue'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    barInfo = json['bar_info'];
    aboutUs = json['about_us'];
    address = json['address'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    havePromotion = json['have_promotion'];
    isLiked = json['is_liked'];
    coverImage = json['cover_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bar_owner_id'] = this.barOwnerId;
    data['venue'] = this.venue;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['bar_info'] = this.barInfo;
    data['about_us'] = this.aboutUs;
    data['address'] = this.address;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['have_promotion'] = this.havePromotion;
    data['is_liked'] = this.isLiked;
    data['cover_image'] = this.coverImage;
    return data;
  }
}
