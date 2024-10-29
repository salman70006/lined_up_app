import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import 'package:com.zat.linedup/Models/BarDetailsResponseModel/BarDetailsResponseModel.dart';
import 'package:com.zat.linedup/Models/ReservationBookingResponseModel/ReservationBookingResponseModel.dart';
import 'package:com.zat.linedup/Utils/Constants/ColorConstants/ColorConstants.dart';

class BarDetailProvider extends ChangeNotifier {
  BarDetailsResponseModel? barDetailsResponseModel;
  List<Peak>? peak;
  List<NonPeak>? nonPeak;
  String? day;
  String? selectedImage;
  ReservationBookingResponseModel? reservationBookingResponseModel;
  bool? isCheck = false;
  List<int> selectedPeakTime = [];
  List<int> selectedNonPeakTime = [];
  String? selectedDay;
  List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  List<Peak>? peakReservation = [];
  List<NonPeak>? nonPeakReservation = [];
  int? selectedMember;
  String? peakPrice;
  String? nonPeakPrice;
  List<int> memberList = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
  ];

  setPrice(String value,String price){
    peakPrice = value;
    nonPeakPrice = price;
    // print(peakPrice);
    // print(nonPeakPrice);
    notifyListeners();
  }
  check(index,BuildContext context) {
    selectedDay = days[index];
    peak = barDetailsResponseModel!.data!.reservation!.peak!;
    nonPeak = barDetailsResponseModel!.data!.reservation!.nonPeak!;

    print(jsonEncode(nonPeak!));
    if(selectedDay!=null){


      peakReservation  = peak?.where((e)=> e.day!.toLowerCase() == selectedDay!.toLowerCase()).toList();
      nonPeakReservation = nonPeak?.where((n)=>n.day!.toLowerCase() ==  selectedDay!.toLowerCase()).toList();
      print(nonPeakReservation);
    }else{
      ShowMessage().showMessage(context, "No slots available!", ColorConstants.redColor);
    }
    notifyListeners();
  }
  barDetails(BarDetailsResponseModel data) {
    barDetailsResponseModel = data;
    notifyListeners();
  }

  bookReservation(ReservationBookingResponseModel data) {
    reservationBookingResponseModel = data;
    notifyListeners();
  }

  peakSlot(int value) {


    selectedPeakTime.contains(value)
        ? selectedPeakTime.remove(value)
        : selectedPeakTime.add(value);
    print("MYYYYYY$selectedPeakTime");
    notifyListeners();
  }
  nonPeakSlot(int value) {

    selectedNonPeakTime.contains(value)
        ? selectedNonPeakTime.remove(value)
        : selectedNonPeakTime.add(value);
    print("NONPEAK$selectedNonPeakTime");
    notifyListeners();
  }
reset(){
  this.selectedNonPeakTime = [];
  this.selectedPeakTime = [];
  this.peakPrice = null;
  this.nonPeakPrice= null;
  this.selectedMember = null;
  notifyListeners();
}
  setValue(bool? value) {
    isCheck = value;
    debugPrint("Value is::::$isCheck");

    notifyListeners();
  }
selectedMemberId(int value){
    selectedMember = value;
    print(selectedMember);
    notifyListeners();
}
showSelectedImage(String index){
    selectedImage = index ;
    print(selectedImage);
    notifyListeners();
}
}
