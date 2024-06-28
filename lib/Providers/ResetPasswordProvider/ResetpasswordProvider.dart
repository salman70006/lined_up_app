import 'package:flutter/cupertino.dart';

class ResetPasswordProvider extends ChangeNotifier{
  bool? showPassword=true;
  passwordToggle(data){
    showPassword = !showPassword!;
    notifyListeners();
  }
}