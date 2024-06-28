class ReservationsDetailResponseModel {
  bool? success;
  String? message;
  Data? data;

  ReservationsDetailResponseModel({this.success, this.message, this.data});

  ReservationsDetailResponseModel.fromJson(Map<String, dynamic> json) {
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
  GetUser? getUser;
  GetBarEvent? getBarEvent;
  GetBarDetail? getBarDetail;

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
        this.isTransferred,
        this.getUser,
        this.getBarEvent,
        this.getBarDetail});

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
    getUser = json['get_user'] != null
        ? new GetUser.fromJson(json['get_user'])
        : null;
    getBarEvent = json['get_bar_event'] != null
        ? new GetBarEvent.fromJson(json['get_bar_event'])
        : null;
    getBarDetail = json['get_bar_detail'] != null
        ? new GetBarDetail.fromJson(json['get_bar_detail'])
        : null;
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
    if (this.getUser != null) {
      data['get_user'] = this.getUser!.toJson();
    }
    if (this.getBarEvent != null) {
      data['get_bar_event'] = this.getBarEvent!.toJson();
    }
    if (this.getBarDetail != null) {
      data['get_bar_detail'] = this.getBarDetail!.toJson();
    }
    return data;
  }
}

class GetUser {
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

  GetUser(
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

  GetUser.fromJson(Map<String, dynamic> json) {
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
class GetBarEvent {
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

  GetBarEvent(
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
        this.updatedAt});

  GetBarEvent.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
class GetBarDetail {
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

  GetBarDetail(
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

  GetBarDetail.fromJson(Map<String, dynamic> json) {
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
