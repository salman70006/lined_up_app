import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:com.zat.linedup/Components/ScaffoldMessageWidget/ScaffoldMessageWidget.dart';
import 'package:com.zat.linedup/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:com.zat.linedup/Controllers/AllReservationService/AllReservationsService.dart';
import 'package:com.zat.linedup/Providers/AllReservationProvider/AllReservationProvider.dart';
import 'package:com.zat.linedup/Providers/LoadingProvider/LoadingProvider.dart';
import 'package:com.zat.linedup/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:provider/provider.dart';

import '../../globals.dart';
import '../CustomMarkBox/CustomMarkBox.dart';

class ReservationFiltersContent extends StatefulWidget {
  const ReservationFiltersContent({super.key});

  @override
  State<ReservationFiltersContent> createState() => _ReservationFiltersContentState();
}

class _ReservationFiltersContentState extends State<ReservationFiltersContent> {



  @override
  Widget build(BuildContext context) {
    return Consumer<AllReservationProvider>(
      builder: (context,allReservationProvider,_ ) {
        return Container(
          width: 250.w,
          height: 150.sp,
          child: Column(
            children: [
              _buildCheckBoxListTile(allReservationProvider.filterType[0], allReservationProvider.isCheckedList[0],0),
              _buildCheckBoxListTile(allReservationProvider.filterType[1], allReservationProvider.isCheckedList[1],1),
              _buildCheckBoxListTile(allReservationProvider.filterType[2], allReservationProvider.isCheckedList[2],2),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        allReservationProvider.resetFilterValue();
                      },
                      child: Text('Reset', style: StaticTextStyle().regular.copyWith(
                          fontSize: 12.sp,
                          color: ColorConstants.textGreyColor
                      ),),
                    ),
                    Consumer<LoadingProvider>(
                      builder: (context, loadingProvider,_) {
                        return InkWell(
                          onTap: ()async{
                            if(allReservationProvider.isCheckedList[0]==true){
                              loadingProvider.setLoading(true);
                              var response = await AllReservationsService().applyFilter(context, allReservationProvider.filterType[0], "", "", "");
                              debugPrint(response.toString());
                              loadingProvider.setLoading(false);
                              if(response?.responseData?.success==true){
                                ShowMessage().showMessage(context, "${response?.responseData?.message}", ColorConstants.appPrimaryColor);
                              }
                            }
                            else if(allReservationProvider.isCheckedList[1]==true){
                              loadingProvider.setLoading(true);
                              var response = await AllReservationsService().applyFilter(context, allReservationProvider.filterType[1], "", "", "");
                              debugPrint(response.toString());
                              loadingProvider.setLoading(false);
                            }else if(allReservationProvider.isCheckedList[2]==true){
                              loadingProvider.setLoading(true);
                              var response = await AllReservationsService().applyFilter(context, allReservationProvider.filterType[2], "", "", "");
                              debugPrint(response.toString());
                              loadingProvider.setLoading(false);
                            }

                          },
                          child:
                         loadingProvider.isLoading?CircularProgressIndicator(color: ColorConstants.appPrimaryColor,):
                          Text('Apply', style: StaticTextStyle().regular.copyWith(
                              fontSize: 12.sp,
                              color: ColorConstants.appPrimaryColor
                          ),),
                        );
                      }
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }


  Widget _buildCheckBoxListTile(String title, bool value, int index){
    return Consumer<AllReservationProvider>(
      builder: (context, allReservationProvider,_) {
        return ListTileTheme(
            horizontalTitleGap: 5.w,
            minVerticalPadding: 0,
            contentPadding: EdgeInsets.zero,
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text(title, style: StaticTextStyle().regular
                  .copyWith(
                  fontSize: 10.sp,
                  color: ColorConstants.textGreyColor
              ),),
              visualDensity: VisualDensity.compact,
              leading: InkWell(
                onTap: (){

                    allReservationProvider.selectedFilterType(index);


                },
                child: CustomPaint(
                  painter: CheckboxPainter(value),
                  child: SizedBox(
                    width: 13.5.w,
                    height: 13.5.sp,
                  ),
                ),
              ),)
        );
      }
    );
  }
}