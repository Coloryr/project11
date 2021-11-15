import 'dart:math';

import 'package:app/main.dart';
import 'package:app/ui/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../bluetooth_utils.dart';
import 'Painter.dart';
import 'loading_dialog.dart';

class DeviceItemUI extends StatefulWidget {
  const DeviceItemUI(this.res, this.close, {Key? key}) : super(key: key);
  final ScanResult res;
  final OnDialogClose close;

  final String title = "数据显示";

  @override
  State<DeviceItemUI> createState() => _DeviceItemPageState();
}

class _DeviceItemPageState extends State<DeviceItemUI> implements OnDialogClose{
  late BluetoothItem item;
  bool visible = true;
  bool init = false;

  _DeviceItemPageState(){
    Future.delayed(const Duration(milliseconds: 100), () { test(); });
  }

  static double angleToRadian(double angle) {
    return angle * pi / 180;
  }

  Offset angleToXY(double angle)
  {
    var radian = angleToRadian(angle);
    return Offset(cos(radian) * 100 + 6, sin(radian) * 100 + 6);
  }

  void close() async {
    await item.item.device.disconnect();
    Future.delayed(const Duration(microseconds: 100), () {
      pop();
      show("连接设备", "连接失败");
    });
  }

  @override
  void dialogClose() {
    if (!init) {
      close();
    }
  }

  void showLoadingDialog() async {
    var dialog = LoadingDialog(this, content: "连接设备中");
    showDialog(context: context, builder: (BuildContext context) { return dialog; });
  }

  // 隐藏加载进度条
  hideLoadingDialog() {
    Navigator.of(context).pop();
  }

  void test() async {
    showLoadingDialog();
    item = BluetoothItem(widget.res);
    if (!await item.ok) {
      pop();
      show("不支持的设备", "你链接的不是指定的设备");
    }
    hideLoadingDialog();
    init = true;
  }

  void _map() {
    goto(const MapUI());
  }

  Widget getLine() {
    List<LinearSales> dataLine = [
      LinearSales( 0, 90),
      LinearSales( 1, 80),
      LinearSales( 2, 70),
      LinearSales( 3, 60),
      LinearSales( 4, 50),
      LinearSales(10, 40),
    ];

    var seriesLine = [
      charts.Series<LinearSales , num>(
        data: dataLine,
        domainFn: (LinearSales  lines, _) => lines.point,
        measureFn: (LinearSales  lines, _) => lines.sale,
        id: "Lines",
      )
    ];
    Widget line = charts.LineChart(seriesLine);
    return line;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(5),
            color: const Color(0xFFFEFEFE),
            height: 120,
            child: Stack(
              children: [
                CustomPaint(
                  foregroundPainter: MyPainter2(
                      lineColor: Colors.lightBlueAccent,
                      width: 5.0,
                      p1: const Offset(6, 6),
                      p2: angleToXY(0)
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(120, 0, 0, 0),
                  child: getLine(),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _map,
        tooltip: 'Increment',
        child: const Icon(Icons.map),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    item.item.device.disconnect();
  }
}


class LinearSales {
  int point;
  int sale;
  LinearSales(this.point, this.sale);
}