
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Utils/Constants/ColorConstants/ColorConstants.dart';

class CheckboxPainter extends CustomPainter {
  final bool isChecked;

  CheckboxPainter(this.isChecked);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isChecked ? ColorConstants.blackColor : Colors.grey.shade300
      ..strokeWidth = 1.sp
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final fillPaint = Paint()
      ..color = isChecked ? Colors.black : Colors.transparent
      ..style = PaintingStyle.fill;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(4.r)
    );

    canvas.drawRRect(rect, fillPaint);
    canvas.drawRRect(rect, paint);

    if (isChecked) {
      final path = Path()
        ..moveTo(size.width * 0.2, size.height * 0.5)
        ..lineTo(size.width * 0.45, size.height * 0.75)
        ..lineTo(size.width * 0.8, size.height * 0.3);

      final checkPaint = Paint()
        ..color = ColorConstants.whiteColor
        ..strokeWidth = 1.sp
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..isAntiAlias = true;

      canvas.drawPath(path, checkPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}