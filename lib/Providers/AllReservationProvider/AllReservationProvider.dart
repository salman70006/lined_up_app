import 'package:flutter/cupertino.dart';
import 'package:com.zat.linedup/Models/AllReservationsModel/AllReservationsModel.dart';
import 'package:com.zat.linedup/Models/ReservationFilterResponseModel/ReservationFilterResponseModel.dart';

class AllReservationProvider extends ChangeNotifier{
  AllReservationsModel? allReservationsModel;
  ReservationFilterResponseModel? filterResponseModel;
  List filterType =[
    "Reservation",
    "Express Reservation",
    "Event Ticket"
  ];
  List filterData=[];
  List isCheckedList  = [
    false,
    false,
    false,
  ];
  allReservation(AllReservationsModel data){
    allReservationsModel = data;
    notifyListeners();
  }

  filteredReservations(ReservationFilterResponseModel data){
    filterResponseModel = data;
    print(filterResponseModel?.filterReservationData?.length);
    notifyListeners();
  }
selectedFilterType(int index){
  resetFilterData();

    isCheckedList[index] = ! isCheckedList[index];
    print(isCheckedList[index]);
    notifyListeners();
}
resetFilterData(){
    filterResponseModel?.filterReservationData =null;
    notifyListeners();
}
resetFilterValue(){
 isCheckedList[0]==false;
 isCheckedList[1]==false;
 isCheckedList[2]==false;
 notifyListeners();
}

}