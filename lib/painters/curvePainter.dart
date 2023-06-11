import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter{

  bool outterCurve;

  CurvePainter(this.outterCurve);


  @override
  void paint(Canvas canvas, Size size) {
    
    var paint = Paint();
    paint.color = Color.fromARGB(255, 20,146,230);
    paint.style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.5, outterCurve ? size.height + 110 : size.height - 110, size.width, size.height);
    path.lineTo(size.width, 0);

    path.close();

    canvas.drawPath(path, paint);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}