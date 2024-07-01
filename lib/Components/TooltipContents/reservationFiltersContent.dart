import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linedup_app/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:linedup_app/Utils/Constants/ColorConstants/ColorConstants.dart';

import '../CustomCheckMarkBox.dart';

class ReservationFiltersContent extends StatefulWidget {
  const ReservationFiltersContent({super.key});

  @override
  State<ReservationFiltersContent> createState() => _ReservationFiltersContentState();
}

class _ReservationFiltersContentState extends State<ReservationFiltersContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      height: 128.sp,
      child: Column(
        children: [
          _buildCheckBoxListTile("Reservations", true),
          _buildCheckBoxListTile("Express reservations", true),
          _buildCheckBoxListTile("Event Tickets", true),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Reset', style: StaticTextStyle().regular.copyWith(
                  fontSize: 12.sp,
                  color: ColorConstants.textGreyColor
                ),),
                Text('Apply', style: StaticTextStyle().regular.copyWith(
                  fontSize: 12.sp,
                  color: ColorConstants.appPrimaryColor
                ),),
              ],
            ),
          )
        ],
      ),
    );
  }


  Widget _buildCheckBoxListTile(String title, bool value){
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
         leading: CustomPaint(
           painter: CheckboxPainter(value),
           child: SizedBox(
             width: 13.5.w,
             height: 13.5.sp,
           ),
         ),)
    );
  }
}
