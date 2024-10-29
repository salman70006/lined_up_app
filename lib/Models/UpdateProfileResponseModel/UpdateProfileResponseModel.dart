class UpdateProfileResponseModel {
  bool? success;
  String? message;
  Data? data;

  UpdateProfileResponseModel({this.success, this.message, this.data});

  UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? userName;
  String? email;
  String? otp;
  String? profileImage;
  String? dob;
  String? gender;
  String? location;
  String? latitude;
  String? longitude;
  String? fcmToken;
  String? googleId;
  String? facebookId;
  String? appleId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.userName,
        this.email,
        this.otp,
        this.profileImage,
        this.dob,
        this.gender,
        this.location,
        this.latitude,
        this.longitude,
        this.fcmToken,
        this.googleId,
        this.facebookId,
        this.appleId,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    email = json['email'];
    otp = json['otp'];
    profileImage = json['profile_image'];
    dob = json['dob'];
    gender = json['gender'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    fcmToken = json['fcm_token'];
    googleId = json['google_id'];
    facebookId = json['facebook_id'];
    appleId = json['apple_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['otp'] = this.otp;
    data['profile_image'] = this.profileImage;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['fcm_token'] = this.fcmToken;
    data['google_id'] = this.googleId;
    data['facebook_id'] = this.facebookId;
    data['apple_id'] = this.appleId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
