class UserRegistrationRequestModel {
  String? userName;
  String? email;
  String? password;
  String? googleId;
  String? facebookId;
  String? appleId;

  UserRegistrationRequestModel(
      {this.userName,
        this.email,
        this.password,
        this.googleId,
        this.facebookId,
        this.appleId});

  UserRegistrationRequestModel.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    email = json['email'];
    password = json['password'];
    googleId = json['google_id'];
    facebookId = json['facebook_id'];
    appleId = json['apple_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['google_id'] = this.googleId;
    data['facebook_id'] = this.facebookId;
    data['apple_id'] = this.appleId;
    return data;
  }
}
