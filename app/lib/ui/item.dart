import 'dart:math';

import 'package:app/ui/painter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Item {
  static const _fillNumber = 20;
  static const double _p1_x = 56;
  static const double _p1_y = 56;
  static const double _length = 42;
  static const double _max_angle = 360;
  double _data =  0.0;
  double get data {
    return _data;
  }
  final List<LinearSales> _dataLine = [];

  static double angleToRadian(double angle) {
    return angle * pi / 180;
  }

  static Offset angleToXY(double angle) {
    var radian = angleToRadian(angle);
    return Offset(cos(radian) * _length + _p1_x, sin(radian) * _length + _p1_y);
  }

  Item() {
    for (int a = 0; a < _fillNumber; a++) {
      _dataLine.add(LinearSales(a, 0));
    }
  }

  void addData(double data) {
    for(var item in _dataLine)
      {
        item.down();
      }
    _dataLine.removeAt(0);
    _dataLine.add(LinearSales(19, data));
    // _old.clear();
    // for (int a = 1; a < _fillNumber; a++) {
    //   _old.add(LinearSales(a - 1, _dataLine[a].sale));
    // }
    // _old.add();
  }

  void update() {
    // _dataLine.clear();
    // _dataLine.addAll(_old);
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
                    const Color.fromARGB(0xff, 0, 0xff, 0), _data / _max_angle)!,
                width: 5.0,
                p1: const Offset(_p1_x, _p1_y),
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

  void down() {
    point --;
  }
}
