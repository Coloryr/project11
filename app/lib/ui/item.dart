import 'dart:math';

import 'package:app/ui/painter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Item {
  static const _fillNumber = 20;
  double _data =  0.0;
  double get data {
    return _data;
  }
  final List<LinearSales> _dataLine = [];
  final List<LinearSales> _old = [];

  static double angleToRadian(double angle) {
    return angle * pi / 180;
  }

  static Offset angleToXY(double angle) {
    var radian = angleToRadian(angle);
    return Offset(cos(radian) * 100 + 6, sin(radian) * 100 + 6);
  }

  Item() {
    for (int a = 0; a < _fillNumber; a++) {
      _dataLine.add(LinearSales(a, 0));
    }
  }

  void addData(double data) {
    _old.clear();
    for (int a = 1; a < _fillNumber; a++) {
      _old.add(LinearSales(a - 1, _dataLine[a].sale));
    }
    _old.add(LinearSales(19, data));
  }

  void update() {
    _dataLine.clear();
    _dataLine.addAll(_old);
    _data = _dataLine[19].sale;
  }

  Widget _getLine() {
    var seriesLine = [
      charts.Series<LinearSales, num>(
        data: _dataLine,
        domainFn: (LinearSales lines, _) => lines.point,
        measureFn: (LinearSales lines, _) => lines.sale,
        id: "Lines"
      )
    ];
    Widget line = charts.LineChart(seriesLine);
    return line;
  }

  Widget getItem() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(5),
      color: const Color(0xFFFEFEFE),
      height: 120,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(90, 100, 0, 0),
            child: Text(data.toStringAsFixed(2)),
          ),
          CustomPaint(
            foregroundPainter: MyPainter2(
                lineColor: Color.lerp(const Color.fromARGB(0xff, 0xff, 0, 0),
                    const Color.fromARGB(0xff, 0, 0xff, 0), _data / 90)!,
                width: 5.0,
                p1: const Offset(6, 6),
                p2: angleToXY(data)),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(120, 0, 0, 0),
            child: _getLine(),
          )
        ],
      ),
    );
  }
}

class LinearSales {
  int point;
  double sale;

  LinearSales(this.point, this.sale);
}
