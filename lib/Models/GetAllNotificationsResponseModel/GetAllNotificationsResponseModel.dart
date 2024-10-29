class GetAllNotificationsResponseModel {
  bool? success;
  String? message;
  List<NotificationsData>? notificationsData;

  GetAllNotificationsResponseModel({this.success, this.message, this.notificationsData});

  GetAllNotificationsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      notificationsData = <NotificationsData>[];
      json['data'].forEach((v) {
        notificationsData!.add(new NotificationsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.notificationsData != null) {
      data['data'] = this.notificationsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationsData {
  int? id;
  int? userId;
  int? bookingId;
  String? title;
  String? description;
  int? isRead;
  String? createdAt;
  String? updatedAt;

  NotificationsData(
      {this.id,
        this.userId,
        this.bookingId,
        this.title,
        this.description,
        this.isRead,
        this.createdAt,
        this.updatedAt});

  NotificationsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bookingId = json['booking_id'];
    title = json['title'];
    description = json['description'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['booking_id'] = this.bookingId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['is_read'] = this.isRead;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
