class GetBarPromotionsResponseModel {
  bool? success;
  String? message;
  Data? data;

  GetBarPromotionsResponseModel({this.success, this.message, this.data});

  GetBarPromotionsResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Daily>? daily;
  List<Weekly>? weekly;

  Data({this.daily, this.weekly});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['daily'] != null) {
      daily = <Daily>[];
      json['daily'].forEach((v) {
        daily!.add(new Daily.fromJson(v));
      });
    }
    if (json['weekly'] != null) {
      weekly = <Weekly>[];
      json['weekly'].forEach((v) {
        weekly!.add(new Weekly.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.daily != null) {
      data['daily'] = this.daily!.map((v) => v.toJson()).toList();
    }
    if (this.weekly != null) {
      data['weekly'] = this.weekly!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Daily {
  int? id;
  String? barId;
  String? barOwnerId;
  String? type;
  String? itemType;
  String? itemPrice;
  String? itemName;
  String? description;
  String? createdAt;
  String? updatedAt;

  Daily(
      {this.id,
        this.barId,
        this.barOwnerId,
        this.type,
        this.itemType,
        this.itemPrice,
        this.itemName,
        this.description,
        this.createdAt,
        this.updatedAt});

  Daily.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barId = json['bar_id'];
    barOwnerId = json['bar_owner_id'];
    type = json['type'];
    itemType = json['item_type'];
    itemPrice = json['item_price'];
    itemName = json['item_name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bar_id'] = this.barId;
    data['bar_owner_id'] = this.barOwnerId;
    data['type'] = this.type;
    data['item_type'] = this.itemType;
    data['item_price'] = this.itemPrice;
    data['item_name'] = this.itemName;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class Weekly{
  int? id;
  String? barId;
  String? barOwnerId;
  String? type;
  String? itemType;
  String? itemPrice;
  String? itemName;
  String? description;
  String? createdAt;
  String? updatedAt;

  Weekly(
      {this.id,
        this.barId,
        this.barOwnerId,
        this.type,
        this.itemType,
        this.itemPrice,
        this.itemName,
        this.description,
        this.createdAt,
        this.updatedAt});

  Weekly.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barId = json['bar_id'];
    barOwnerId = json['bar_owner_id'];
    type = json['type'];
    itemType = json['item_type'];
    itemPrice = json['item_price'];
    itemName = json['item_name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bar_id'] = this.barId;
    data['bar_owner_id'] = this.barOwnerId;
    data['type'] = this.type;
    data['item_type'] = this.itemType;
    data['item_price'] = this.itemPrice;
    data['item_name'] = this.itemName;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
