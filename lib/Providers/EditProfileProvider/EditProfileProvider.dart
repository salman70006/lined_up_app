import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:com.zat.linedup/Models/UpdateProfileResponseModel/UpdateProfileResponseModel.dart';

class EditProfileProvider extends ChangeNotifier {
  List genderList = ["Male", "Female"];
  String? selectedGender;

  File? file;
  UpdateProfileResponseModel? updateProfileResponseModel;

  setSelectedGender(String value) {
    selectedGender = value;
    notifyListeners();
  }

  updateProfile(UpdateProfileResponseModel data) {
    updateProfileResponseModel = data;
    notifyListeners();
  }

  uploadImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      final image = await picker.pickImage(source: source);
      if(image!=null){
        file = File(image.path);
        print(file?.path);
      }else{

      }

    } on PlatformException catch (e) {
      print("Failed to pick Image: $e");
    }
    notifyListeners();
  }
}
