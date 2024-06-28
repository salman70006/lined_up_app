class PrivacyPolicyAndTCResponseModel {
  bool? success;
  String? privacyPolicy;
  String? termAndCondition;

  PrivacyPolicyAndTCResponseModel(
      {this.success, this.privacyPolicy, this.termAndCondition});

  PrivacyPolicyAndTCResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    privacyPolicy = json['privacy_policy'];
    termAndCondition = json['term_and_condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['privacy_policy'] = this.privacyPolicy;
    data['term_and_condition'] = this.termAndCondition;
    return data;
  }
}
