import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linedup_app/Components/StaticTextStyle/StaticTextStyle.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../Utils/Constants/ColorConstants/ColorConstants.dart';

class DistanceTooltipContent extends StatefulWidget {
  const DistanceTooltipContent({super.key});

  @override
  State<DistanceTooltipContent> createState() => _DistanceTooltipContentState();
}

class _DistanceTooltipContentState extends State<DistanceTooltipContent> {
  double _value = 75.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      height: 128.sp,
      // color: Colors.red,
      child: Column(
        children: [
          SizedBox(
            height: 10.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('0km', style: TextStyle(fontSize: 12.sp, color: ColorConstants.textGreyColor)),
                Text('100km', style: TextStyle(fontSize: 12.sp, color: ColorConstants.textGreyColor)),
              ],
            ),
          ),
          SfSliderTheme(
            data: SfSliderThemeData(
              activeTrackHeight: 8.sp,
              inactiveTrackHeight: 8.sp,
              tooltipBackgroundColor: ColorConstants.daysDotColor,
              activeTrackColor: ColorConstants.daysDotColor,
              inactiveTrackColor: ColorConstants.dotsGreyColor,
            ),
            child: SfSlider(
              min: 0.0,
              max: 100.0,
              shouldAlwaysShowTooltip: true,
              value: _value,
              // interval: 20,
              showTicks: false,
              showLabels: false,
              enableTooltip: true,
              minorTicksPerInterval: 1,
              onChanged: (dynamic val) {
                setState(() {
                  _value = val;
                });
              },
              thumbShape: MultiColorCircleThumbShape(),
              tooltipShape: CustomTooltipShape(),
            ),
          ),
          Spacer(),
          InkWell(
            onTap: (){},
            child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 5.sp),
                  child: Text('Apply',
                      style: TextStyle(fontSize: 12.sp, color: ColorConstants.daysDotColor, fontWeight: FontWeight.w400)),
                )),
          ),
        ],
      ),
    );
  }
}

class MultiColorCircleThumbShape extends SfThumbShape {
  // static const double _thumbRadius = 12.0;
  // static const double _innerCircleRadius = 6.0;
  //
  // @override
  // Size getPreferredSize() {
  //   return Size.fromRadius(_thumbRadius);
  // }

  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
      required RenderBox? child,
      required SfSliderThemeData themeData,
      SfRangeValues? currentValues,
      dynamic currentValue,
      required Paint? paint,
      required Animation<double> enableAnimation,
      required TextDirection textDirection,
      required SfThumb? thumb}) {
    final Canvas canvas = context.canvas;

    // Draw the shadow
    final Path shadowPath = Path()..addOval(Rect.fromCircle(center: center, radius: 6.5.r));
    canvas.drawShadow(shadowPath, ColorConstants.textGreyColor, 3.0, true);

    // Outer circle (larger)
    final Paint outerCirclePaint = Paint()
      ..color = ColorConstants.dotsGreyColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 6.5.r, outerCirclePaint);

    // Inner circle (smaller)
    final Paint innerCirclePaint = Paint()
      ..color = ColorConstants.whiteColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 6.r, innerCirclePaint);
  }
}

class CustomTooltipShape extends SfTooltipShape {
  @override
  @override
  void paint(PaintingContext context, Offset thumbCenter, Offset offset, TextPainter textPainter,
      {required RenderBox parentBox,
      required SfSliderThemeData sliderThemeData,
      required Paint paint,
      required Animation<double> animation,
      required Rect trackRect}) {
    // TODO: implement paint
    final Paint paint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

    final String displayValue = '${textPainter.text!.toPlainText()} km';
    final TextSpan span = TextSpan(
      text: displayValue,
      style: TextStyle(color: ColorConstants.textGreyColor, fontSize: 10.sp),
    );

    final TextPainter customTextPainter = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    customTextPainter.layout();

    final double textWidth = customTextPainter.width;
    final double textHeight = customTextPainter.height;

    final double tooltipHeight = textHeight + 10; // Add some padding
    final double tooltipWidth = textWidth + 10; // Add some padding

    final Rect rect = Rect.fromLTWH(
      thumbCenter.dx - (tooltipWidth / 2),
      thumbCenter.dy + 10, // Position it below the thumb
      tooltipWidth,
      tooltipHeight,
    );

    final RRect tooltipRect = RRect.fromRectAndRadius(rect, Radius.circular(4));

    context.canvas.drawRRect(tooltipRect, paint);

    // Draw the text
    customTextPainter.paint(
      context.canvas,
      Offset(
        rect.left + (tooltipWidth - textWidth) / 2,
        rect.top + (tooltipHeight - textHeight) / 2,
      ),
    );
  }
}
