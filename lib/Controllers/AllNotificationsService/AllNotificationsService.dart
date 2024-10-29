import 'dart:convert';

import 'package:com.zat.linedup/Models/DeleteSingleNotificationResponseModel/DeleteSingleNotificationResponseModel.dart';
import 'package:com.zat.linedup/Models/MarkAsReadResponseModel/MarkAsReadResponseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/API/api.dart';
import 'package:com.zat.linedup/API/api_response.dart';
import 'package:com.zat.linedup/ApiEndPoints/ApiEndPoints.dart';
import 'package:com.zat.linedup/Models/DeleteAllNotificationsResponseModel/DeleteAllNotificationsResponseModel.dart';
import 'package:com.zat.linedup/Models/GetAllNotificationsResponseModel/GetAllNotificationsResponseModel.dart';
import 'package:com.zat.linedup/Providers/NotificationsProvider/NotificationsProvider.dart';
import 'package:provider/provider.dart';

class AllNotificationsService {

  Future<ApiResponse<GetAllNotificationsResponseModel>>? getAllNotifications(BuildContext context)async{
    try{
      var notificationsProvider = Provider.of<NotificationsProvider>(context,listen: false);

      var response = await Api.getRequestData(ApiEndPoints.getNotifications, context);
      debugPrint("NotificationsApiResponse:::$response");
      GetAllNotificationsResponseModel responseModel = GetAllNotificationsResponseModel.fromJson(jsonDecode(response));
      debugPrint("NotificationsModelApiResponse::::${responseModel.toJson()}");
      notificationsProvider.notifications(responseModel);
      return ApiResponse.completed(responseModel);
    }catch(e){
      debugPrint("NotificationsApiErrorResponse${e.toString()}");
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<DeleteAllNotificationsResponseModel>>? deleteAll(BuildContext context)async{
    try{
      var response = await Api.getRequestData(ApiEndPoints.deleteAll, context);
      debugPrint("DeleteAllNotificationsApiResponse:$response");
      DeleteAllNotificationsResponseModel responseModel = DeleteAllNotificationsResponseModel.fromJson(jsonDecode(response));
      return ApiResponse.completed(responseModel);
    }catch(e){
      debugPrint("DeleteAllNotificationsApiResponse:${e.toString()}");
      return ApiResponse.error(e.toString());
    }
    
  }
  Future<ApiResponse<DeleteSingleNotificationResponseModel>>? deleteSingle(BuildContext context,int notificationId)async{
    try{
      var response = await Api.getRequestData("delete-single?notification_id=$notificationId", context);
      debugPrint("DeleteSingleNotificationsApiResponse:$response");
      DeleteSingleNotificationResponseModel responseModel = DeleteSingleNotificationResponseModel.fromJson(jsonDecode(response));
      return ApiResponse.completed(responseModel);
    }catch(e){
      debugPrint("DeleteSingleNotificationsApiResponse:${e.toString()}");
      return ApiResponse.error(e.toString());
    }

  }
  Future<ApiResponse<MarkAsReadResponseModel>>? markAsRead(BuildContext context,int notificationId)async{
    try{
      var response = await Api.getRequestData("mark-notification-as-read?notification_id=$notificationId", context);
      debugPrint("DeleteSingleNotificationsApiResponse:$response");
      MarkAsReadResponseModel responseModel = MarkAsReadResponseModel.fromJson(jsonDecode(response));
      return ApiResponse.completed(responseModel);
    }catch(e){
      debugPrint("DeleteSingleNotificationsApiResponse:${e.toString()}");
      return ApiResponse.error(e.toString());
    }

  }
}