import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:com.zat.linedup/Utils/Constants/ColorConstants/ColorConstants.dart';
import 'package:shimmer/shimmer.dart';

class ImageWidget extends StatelessWidget {
  String? imageUrl;
  double? height,width,imageHeight,imageWidth;
  BoxFit? fit;
  Color? blendColor;
  BlendMode? blendMode;
  Decoration? decoration;
  BorderRadiusGeometry? borderRadius;
  ImageWidget({
    this.imageUrl,
    this.height,
    this.width,
    this.fit,
    this.blendColor,
    this.blendMode,
    this.decoration,
    this.borderRadius,
    this.imageHeight,
    this.imageWidth
});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: decoration,
      child: ClipRRect(
        borderRadius: borderRadius??BorderRadius.zero,
        child: CachedNetworkImage(
          imageUrl: imageUrl??"",
          height: imageHeight,
          width: imageWidth,
          fit: fit,
          color: blendColor,
          colorBlendMode: blendMode,
          placeholder: (context,url) => Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white30,
            child: Container(
             color: Colors.grey,
            ),
          ),
          errorWidget: (context,url,error)=> Container(child: Image.asset("assets/Images/place_holder.png"),),
    ),
      ),
    );
  }
}
