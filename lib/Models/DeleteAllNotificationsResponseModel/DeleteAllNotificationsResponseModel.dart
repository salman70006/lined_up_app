class DeleteAllNotificationsResponseModel {
  final bool? success;
  final String? message;
  final List<dynamic>? data;

  DeleteAllNotificationsResponseModel({
    this.success,
    this.message,
    this.data,
  });

  DeleteAllNotificationsResponseModel.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        message = json['message'] as String?,
        data = json['data'] as List?;

  Map<String, dynamic> toJson() => {
    'success' : success,
    'message' : message,
    'data' : data
  };
}