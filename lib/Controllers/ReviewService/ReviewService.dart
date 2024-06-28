import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:linedup_app/API/api.dart';
import 'package:linedup_app/API/api_response.dart';
import 'package:linedup_app/ApiEndPoints/ApiEndPoints.dart';
import 'package:linedup_app/Models/GiveReviewRequestModel/GiveReviewRequestModel.dart';
import 'package:linedup_app/Models/GiveReviewResponseModel/GiveReviewResponseModel.dart';
import 'package:linedup_app/Providers/ReservationsDetailProvider/ReservationDetailProvider.dart';
import 'package:provider/provider.dart';

class ReviewService {

  Future<ApiResponse<GiveReviewResponseModel>?>  giveReview(BuildContext context,String barId,int rating)async{
    var detailProvider = Provider.of<ReservationDetailProvider>(context,listen: false);
    GiveReviewRequestModel giveReviewRequestModel = GiveReviewRequestModel(
      barId: barId,
      rating: rating
    );
    debugPrint("review Request Body:${giveReviewRequestModel.barId},${giveReviewRequestModel.rating}");

    try{
      var response = await Api.postRequestData(ApiEndPoints.addReview, giveReviewRequestModel, context,sendToken: true);
      debugPrint("review Api Response: $response");
      GiveReviewResponseModel giveReviewResponseModel = GiveReviewResponseModel.fromJson(jsonDecode(response));
      debugPrint("review Api Model Response: ${giveReviewResponseModel.toJson()}");
      detailProvider.review(giveReviewResponseModel);
      return ApiResponse.completed(giveReviewResponseModel);
    }catch (e){
      debugPrint("review Api Error Response: ${e.toString()}");
      return ApiResponse.error(e.toString());
    }
  }
}