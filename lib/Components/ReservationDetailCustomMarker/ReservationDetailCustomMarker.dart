import 'package:flutter/material.dart';
import 'package:com.zat.linedup/Utils/Constants/ColorConstants/ColorConstants.dart';

class CustomMarker extends StatelessWidget {
  final String time;
  final String distance;

  CustomMarker({required this.time, required this.distance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ColorConstants.appPrimaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            time,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            distance,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
