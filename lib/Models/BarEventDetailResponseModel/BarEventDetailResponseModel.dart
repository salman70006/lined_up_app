class BarEventDetailResponseModel {
  bool? success;
  String? message;
  Data? data;

  BarEventDetailResponseModel({this.success, this.message, this.data});

  BarEventDetailResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? barOwnerId;
  String? barId;
  String? title;
  String? date;
  String? startTime;
  String? endTime;
  String? about;
  String? price;
  List<String>? images;
  String? numberOfTickets;
  bool? status;
  String? createdAt;
  String? updatedAt;
  GetBarInfo? getBarInfo;

  Data(
      {this.id,
        this.barOwnerId,
        this.barId,
        this.title,
        this.date,
        this.startTime,
        this.endTime,
        this.about,
        this.price,
        this.images,
        this.numberOfTickets,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.getBarInfo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barOwnerId = json['bar_owner_id'];
    barId = json['bar_id'];
    title = json['title'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    about = json['about'];
    price = json['price'];
    images = json['images'].cast<String>();
    numberOfTickets = json['number_of_tickets'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    getBarInfo = json['get_bar_info'] != null
        ? new GetBarInfo.fromJson(json['get_bar_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bar_owner_id'] = this.barOwnerId;
    data['bar_id'] = this.barId;
    data['title'] = this.title;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['about'] = this.about;
    data['price'] = this.price;
    data['images'] = this.images;
    data['number_of_tickets'] = this.numberOfTickets;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.getBarInfo != null) {
      data['get_bar_info'] = this.getBarInfo!.toJson();
    }
    return data;
  }
}

class GetBarInfo {
  int? id;
  String? barOwnerId;
  String? venue;
  List<String>? barInfo;
  String? aboutUs;
  String? address;
  String? startTime;
  String? endTime;
  bool? havePromotion;
  bool? isLiked;
  String? coverImage;

  GetBarInfo(
      {this.id,
        this.barOwnerId,
        this.venue,
        this.barInfo,
        this.aboutUs,
        this.address,
        this.startTime,
        this.endTime,
        this.havePromotion,
        this.isLiked,
        this.coverImage});

  GetBarInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barOwnerId = json['bar_owner_id'];
    venue = json['venue'];
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
