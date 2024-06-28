import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:linedup_app/Utils/Constants/ColorConstants/ColorConstants.dart';

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
        ),
      ),
    );
  }
}
