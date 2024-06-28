

import 'package:flutter/material.dart';
class ProfileBackgroundImage extends StatefulWidget {
   ProfileBackgroundImage({
     this.width,
     this.height,
     required this.child,
     this.padding,
     this.circleRadius,
     this.cardBorderRadius,
     this.margin,
     this.color = Colors.white,
     this.isCornerRounded = false,
     this.shadow,});
   final double? width;
   final double? height;
   double? circleRadius, cardBorderRadius;
   final Widget child;
   final Color color;
   final bool isCornerRounded;
   final EdgeInsetsGeometry? padding;
   final EdgeInsetsGeometry? margin;
   final List<BoxShadow>? shadow;
  @override
  State<ProfileBackgroundImage> createState() => _ProfileBackgroundImageState();
}

class _ProfileBackgroundImageState extends State<ProfileBackgroundImage> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(circleRadius: widget.circleRadius),
      child: AnimatedContainer(
        child: widget.child,
        duration: const Duration(seconds: 1),
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        margin: widget.margin,
        decoration: BoxDecoration(
          boxShadow: widget.shadow,
          color: widget.color,
          borderRadius: widget.isCornerRounded
              ? BorderRadius.circular(widget.cardBorderRadius ?? 20.0)
              : BorderRadius.circular(0.0),
        ),
      ),
    );
  }
}


class TicketClipper extends CustomClipper<Path> {
  double? circleRadius;

  TicketClipper({this.circleRadius});

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.addOval(Rect.fromCircle(center: Offset(size.height / 2.75,0.0 ), radius: circleRadius ?? 20.0));
    // path.addOval(Rect.fromCircle(center: Offset(size.width, size.height / 2.75), radius: circleRadius ?? 20.0));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}