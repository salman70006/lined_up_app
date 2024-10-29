import 'dart:io';

import 'package:dio/dio.dart';

class UpdateProfileRequestModel {
  String? userName;
  String? email;
  String? dob;
  String? gender;
  MultipartFile? profileImage;

  UpdateProfileRequestModel(
      {this.userName, this.email, this.dob, this.gender, this.profileImage});

  UpdateProfileRequestModel.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    email = json['email'];
    dob = json['dob'];
    gender = json['gender'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
