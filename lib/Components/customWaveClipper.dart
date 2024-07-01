import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width*-0.0014933,size.height*-0.0007930);
    path_0.lineTo(size.width*-0.0029454,size.height*0.9879466);
    path_0.quadraticBezierTo(size.width*0.0512000,size.height*1.0002203,size.width*0.1624533,size.height*0.9900441);
    path_0.cubicTo(size.width*0.2797600,size.height*0.9282379,size.width*0.4394933,size.height*0.7552423,size.width*0.4894400,size.height*0.6539207);
    path_0.cubicTo(size.width*0.5368533,size.height*0.7570044,size.width*0.7240000,size.height*0.9141850,size.width*0.8584800,size.height*1.0056388);
    path_0.quadraticBezierTo(size.width*0.9351733,size.height*1.0066960,size.width*1.0021697,size.height*1.0000303);
    path_0.lineTo(size.width*1.0041862,size.height*-0.0062374);
    path_0.lineTo(size.width*-0.0014933,size.height*-0.0007930);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) => false;
}