import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linedup_app/Utils/Constants/AssetConstants/AssetConstants.dart';

class RatingWidget extends StatefulWidget {
  double? initialRating,minRating;
  void Function(double)? onRatingUpdate;
  bool? ignoreGestures;
   RatingWidget({
    this.initialRating,
     this.minRating,
     this.onRatingUpdate,
     this.ignoreGestures=false
});

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: widget.initialRating!,
      minRating: widget.minRating??0,
      direction: Axis.horizontal,
      allowHalfRating: false,
      ignoreGestures: widget.ignoreGestures!,
      itemCount: 5,
      itemPadding: EdgeInsets.zero,
      itemSize: 30.sp,
      itemBuilder: (context, _) => SvgPicture.asset(AssetConstants.starIcon,color: Colors.amber,),
      onRatingUpdate:widget.onRatingUpdate?? (rating) {
        print(rating);
      },
    );
  }
}
