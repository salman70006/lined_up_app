class LoginRequestModel {
  String? email;
  String? password;
  String? loginType;
  String? googleId;
  String? facebookId;
  String? appleId;
  String? fcmToken;

  LoginRequestModel(
      {this.email,
        this.password,
        this.loginType,
        this.googleId,
        this.facebookId,
        this.appleId,
        this.fcmToken});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    loginType = json['login_type'];
    googleId = json['google_id'];
    facebookId = json['facebook_id'];
    appleId = json['apple_id'];
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['login_type'] = this.loginType;
    data['google_id'] = this.googleId;
    data['facebook_id'] = this.facebookId;
    data['apple_id'] = this.appleId;
    data['fcm_token'] = this.fcmToken;
    return data;
  }
}
