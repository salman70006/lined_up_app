class WishListSearchResponseModel {
  bool? success;
  String? message;
  List<WishListData>? data;

  WishListSearchResponseModel({this.success, this.message, this.data});

  WishListSearchResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <WishListData>[];
      json['data'].forEach((v) {
        data!.add(new WishListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WishListData {
  int? id;
  String? userId;
  String? barId;
  bool? isLiked;
  String? createdAt;
  String? updatedAt;
  GetBar? getBar;

  WishListData(
      {this.id,
        this.userId,
        this.barId,
        this.isLiked,
        this.createdAt,
        this.updatedAt,
        this.getBar});

  WishListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    barId = json['bar_id'];
    isLiked = json['is_liked'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    getBar =
    json['get_bar'] != null ? new GetBar.fromJson(json['get_bar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['bar_id'] = this.barId;
    data['is_liked'] = this.isLiked;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.getBar != null) {
      data['get_bar'] = this.getBar!.toJson();
    }
    return data;
  }
}

class GetBar {
  int? id;
  String? barOwnerId;
  String? venue;
  String? longitude;
  String? latitude;
  List<String>? barInfo;
  String? aboutUs;
  String? address;
  String? startTime;
  String? endTime;
  bool? havePromotion;
  bool? isLiked;
  String? coverImage;

  GetBar(
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

  GetBar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barOwnerId = json['bar_owner_id'];
    venue = json['venue'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    barInfo = json['bar_info'].cast<String>();
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
