class ResetPasswordRequestModel {
  String? email;
  String? password;
  String? confirmPassword;

  ResetPasswordRequestModel({this.email, this.password, this.confirmPassword});

  ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['confirm_password'] = this.confirmPassword;
    return data;
  }
}
