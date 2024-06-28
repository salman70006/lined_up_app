class GiveReviewResponseModel {
  bool? success;
  String? message;
  Data? data;

  GiveReviewResponseModel({this.success, this.message, this.data});

  GiveReviewResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? barId;
  int? rating;
  int? id;

  Data({this.userId, this.barId, this.rating, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    barId = json['bar_id'];
    rating = json['rating'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['bar_id'] = this.barId;
    data['rating'] = this.rating;
    data['id'] = this.id;
    return data;
  }
}
