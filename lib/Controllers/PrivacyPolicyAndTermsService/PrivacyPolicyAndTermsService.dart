import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:linedup_app/API/api.dart';
import 'package:linedup_app/API/api_response.dart';
import 'package:linedup_app/ApiEndPoints/ApiEndPoints.dart';
import 'package:linedup_app/Models/PrivacyPolicyAndTCResponseModel/PrivacyPolicyAndTCResponseModel.dart';
import 'package:linedup_app/Providers/privacyPolicyProvider/PrivacyPolicyProvider.dart';
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