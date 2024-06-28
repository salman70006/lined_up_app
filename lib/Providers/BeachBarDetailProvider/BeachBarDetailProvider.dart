import 'package:flutter/cupertino.dart';

class BeachBarDetailProvider extends ChangeNotifier {

  List days = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun"
  ];
  List timeSlots = [
    "9:00 Pm",
    "9:30 Pm",
    "10:00 Pm",
    "1:00 Am",
    "1:30 Am",
    "N/A",
    "N/A",
    "N/A",
  ];
  List memberList = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
  ];
  List selectedDay =[];
  List selectedTime = [];
  bool? isRemember=false;
  List selectedMember = [];
  check(value){
    if(days.contains(value)){
      selectedDay.add(value);
      print("Added::::::$selectedDay");
      notifyListeners();

    } else{
    selectedDay.removeWhere((element){
      return element == value;

    });
    notifyListeners();

    }

  }
  checkTime(value){
    if(timeSlots.contains(value)){
      selectedTime.add(value);
      print("Added::::::$selectedTime");
      notifyListeners();

    } else{
      selectedTime.removeWhere((element){
        return element == value;

      });
      notifyListeners();

    }

  }

memberCount(value){
  if(memberList.contains(value)){
    selectedMember.add(value);
    print("Added::::::$selectedMember");
    notifyListeners();

  } else{
    selectedMember.removeWhere((element){
      return element == value;

    });
    notifyListeners();

  }
}

}