import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:com.zat.linedup/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:com.zat.linedup/Utils/Constants/AssetConstants/AssetConstants.dart';
import 'package:com.zat.linedup/Utils/Constants/ColorConstants/ColorConstants.dart';

class MarkerWidget extends StatefulWidget {
   MarkerWidget({this.text});
   String? text;
  @override
  State<MarkerWidget> createState() => _MarkerWidgetState();
}

class _MarkerWidgetState extends State<MarkerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child:
        Row(
          children: [
            Image(image: AssetImage(AssetConstants.locationIcon,),height: 18.sp,width: 18.sp
                ),
            SizedBox(width: 10.sp,),
            Text(widget.text.toString(),style: StaticTextStyle().regular.copyWith(
    color: ColorConstants.blackColor,
              fontSize: 15.sp,

    ),)
          ],
        ));
  }
}
