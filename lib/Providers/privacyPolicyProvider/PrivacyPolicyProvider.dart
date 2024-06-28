import 'package:flutter/cupertino.dart';

import '../../Models/PrivacyPolicyAndTCResponseModel/PrivacyPolicyAndTCResponseModel.dart';

class PrivacyPolicyAndTcProvider extends ChangeNotifier{
  PrivacyPolicyAndTCResponseModel? policyAndTCResponseModel;
  policyAndTc(PrivacyPolicyAndTCResponseModel data){
    policyAndTCResponseModel = data;
    notifyListeners();
  }

}