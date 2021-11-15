import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Painter.dart';

class MapUI extends StatefulWidget {
  const MapUI({Key? key}) : super(key: key);

  final String title = "地图样式显示";

  @override
  State<MapUI> createState() => _DeviceItemPageState();
}

class _DeviceItemPageState extends State<MapUI> {
  String _data = "0.0";
  String _data1 = "0.0";

  set data(String data) {
    setState(() {
      _data = data;
    });
  }

  set data1(String data) {
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
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Stack(
              children: [
                Image.asset("images/map.png"),
                Container(
                  padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
                  child: Text(_data, style: const TextStyle(
                      color: Colors.blue,
                      backgroundColor: Colors.white
                  )),
                ),
                CustomPaint(
                  foregroundPainter: MyPainter(
                    lineColor: Colors.lightBlueAccent,
                    width: 5.0,
                    p1: const Offset(42, 37),
                    p2: const Offset(80, 120)
                  ),
                ),
                CustomPaint(
                  foregroundPainter: MyPainter1(
                      lineColor: Colors.lightBlueAccent,
                      width: 5.0,
                      p1: const Offset(84, 128),
                      radius: 8
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(300, 60, 0, 0),
                  child: Text(_data1, style: const TextStyle(
                      color: Colors.yellow,
                      backgroundColor: Colors.white
                  )),
                ),
                CustomPaint(
                  foregroundPainter: MyPainter(
                      lineColor: Colors.orangeAccent,
                      width: 5.0,
                      p1: const Offset(300, 76),
                      p2: const Offset(260, 180)
                  ),
                ),
                CustomPaint(
                  foregroundPainter: MyPainter1(
                      lineColor: Colors.orangeAccent,
                      width: 5.0,
                      p1: const Offset(256, 190),
                      radius: 8
                  ),
                )
              ],
            )
        )
    );
  }
}