import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/API/api.dart';
import 'package:com.zat.linedup/API/api_response.dart';
import 'package:com.zat.linedup/ApiEndPoints/ApiEndPoints.dart';
import 'package:com.zat.linedup/Models/PrivacyPolicyAndTCResponseModel/PrivacyPolicyAndTCResponseModel.dart';
import 'package:com.zat.linedup/Providers/privacyPolicyProvider/PrivacyPolicyProvider.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyAndTermsService{
  
  Future<ApiResponse<PrivacyPolicyAndTCResponseModel>?> getPrivacyAndTerms(BuildContext context)async{
    var privacyAndTermsProvider = Provider.of<PrivacyPolicyAndTcProvider>(context,listen: false);
    try{
      var response = await Api.getRequestData(ApiEndPoints.PrivacyAndTerms, context);
      debugPrint("Privacy Api Response:$response");
      PrivacyPolicyAndTCResponseModel policyAndTCResponseModel = PrivacyPolicyAndTCResponseModel.fromJson(jsonDecode(response));
      debugPrint("Privacy Model Response:${policyAndTCResponseModel.toJson()}");
      privacyAndTermsProvider.policyAndTc(policyAndTCResponseModel);
      return ApiResponse.completed(policyAndTCResponseModel);
    }catch (e){
      debugPrint("Privacy Api Error Response:${e.toString()}");
      return ApiResponse.error(e.toString());
    }
    
  }
}