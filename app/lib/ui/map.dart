import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Painter.dart';

abstract class OnMapClose {
  void mapClose();
}

class MapUI extends StatefulWidget {
  final OnMapClose _close;

  MapUI(this._close, {Key? key}) : super(key: key);
  late _DeviceItemPageState _state;

  set data(double data) {
    _state.data = data;
  }

  set data1(double data) {
    _state.data1 = data;
  }

  final String _title = "地图样式显示";

  @override
  State<MapUI> createState() => _DeviceItemPageState();
}

class _DeviceItemPageState extends State<MapUI> {
  double _data = 0.0;
  double _data1 = 0.0;

  set data(double data) {
    setState(() {
      _data = data;
    });
  }

  set data1(double data) {
    setState(() {
      _data1 = data;
    });
  }

  _DeviceItemPageState() {
    // SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  Widget build(BuildContext context) {
    widget._state = this;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget._title),
        ),
        body: Center(
            child: Stack(
          children: [
            Image.asset("images/map.png"),
            Container(
              padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
              child: Text(_data.toStringAsFixed(3),
                  style: const TextStyle(
                      color: Colors.blue, backgroundColor: Colors.white)),
            ),
            CustomPaint(
              foregroundPainter: MyPainter(
                  lineColor: Colors.lightBlueAccent,
                  width: 5.0,
                  p1: const Offset(42, 37),
                  p2: const Offset(80, 120)),
            ),
            CustomPaint(
              foregroundPainter: MyPainter1(
                  lineColor: Colors.lightBlueAccent,
                  width: 5.0,
                  p1: const Offset(84, 128),
                  radius: 8),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(300, 60, 0, 0),
              child: Text(_data1.toStringAsFixed(3),
                  style: const TextStyle(
                      color: Colors.yellow, backgroundColor: Colors.white)),
            ),
            CustomPaint(
              foregroundPainter: MyPainter(
                  lineColor: Colors.orangeAccent,
                  width: 5.0,
                  p1: const Offset(300, 76),
                  p2: const Offset(260, 180)),
            ),
            CustomPaint(
              foregroundPainter: MyPainter1(
                  lineColor: Colors.orangeAccent,
                  width: 5.0,
                  p1: const Offset(256, 190),
                  radius: 8),
            )
          ],
        )));
  }
  @override
  void dispose() {
    widget._close.mapClose();
    super.dispose();
  }
}
