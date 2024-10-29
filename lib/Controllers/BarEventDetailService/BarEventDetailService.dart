import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/API/api.dart';
import 'package:com.zat.linedup/API/api_response.dart';
import 'package:com.zat.linedup/Models/BarEventDetailResponseModel/BarEventDetailResponseModel.dart';
import 'package:com.zat.linedup/Providers/BarEventDetailProvider/BarEventDetailProvider.dart';
import 'package:provider/provider.dart';

class BarEventDetailService{

  Future<ApiResponse<BarEventDetailResponseModel>?> getEventsDetail(BuildContext context,int? eventId)async{

    var detailProvider = Provider.of<EventDetailProvider>(context,listen: false);

    try{
      var response = await Api.getRequestData("get-bar-event-detail?bar_event_id=$eventId", context);
      debugPrint("Bar Details Api response:$response");
      BarEventDetailResponseModel barEventDetailResponseModel = BarEventDetailResponseModel.fromJson(jsonDecode(response));
      debugPrint("Bar Details Model response:${barEventDetailResponseModel.toJson()}");
      detailProvider.eventsDetail(barEventDetailResponseModel);
      return ApiResponse.completed(barEventDetailResponseModel);
    }catch(e){
      debugPrint("Bar Details Api Error response:${e.toString()}");
      return ApiResponse.error(e.toString());
    }

  }

}