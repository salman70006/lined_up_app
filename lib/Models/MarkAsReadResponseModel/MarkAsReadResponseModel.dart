class MarkAsReadResponseModel {
  final bool? success;
  final String? message;
  final List<dynamic>? data;

  MarkAsReadResponseModel({
    this.success,
    this.message,
    this.data,
  });

  MarkAsReadResponseModel.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        message = json['message'] as String?,
        data = json['data'] as List?;

  Map<String, dynamic> toJson() => {
    'success' : success,
    'message' : message,
    'data' : data
  };
}