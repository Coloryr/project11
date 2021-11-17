import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  Color lineColor;
  double width;
  Offset p1;
  Offset p2;

  MyPainter(
      {required this.lineColor,
      required this.width,
      required this.p1,
      required this.p2});

  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(p1, p2, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class MyPainter1 extends CustomPainter {
  Color lineColor;
  double width;
  Offset p1;
  double radius;

  MyPainter1(
      {required this.lineColor,
      required this.width,
      required this.p1,
      required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(p1, radius, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class MyPainter2 extends CustomPainter {
  Color lineColor;
  double width;
  Offset p1;
  Offset p2;

  MyPainter2(
      {required this.lineColor,
      required this.width,
      required this.p1,
      required this.p2});

  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;
    Paint _paint1 = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;
    Rect rect = Rect.fromCircle(center: p1, radius: 2);
    canvas.drawRect(rect, _paint1);
    canvas.drawLine(p1, p2, _paint);
    double x = p2.dx - p1.dx;
    double y = p2.dy - p1.dy;
    canvas.drawCircle(p2.translate(x * 0.12, y * 0.12), 5, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
