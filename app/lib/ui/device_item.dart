import 'dart:math';

import 'package:app/main.dart';
import 'package:app/ui/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../bluetooth_utils.dart';
import 'item.dart';
import 'loading_dialog.dart';

class DeviceItemUI extends StatefulWidget {
  const DeviceItemUI(this.res, this.close, {Key? key}) : super(key: key);
  final ScanResult? res;
  final OnDialogClose? close;

  final String title = "数据显示";

  @override
  State<DeviceItemUI> createState() => _DeviceItemPageState();
}

class _DeviceItemPageState extends State<DeviceItemUI>
    implements OnDialogClose, OnData, OnMapClose {
  late BluetoothItem _item;
  bool _init = false;
  bool _isMap = false;
  final Item _a1 = Item();
  final Item _a2 = Item();
  final Item _a3 = Item();
  final Item _a4 = Item();
  final Item _a5 = Item();
  late MapUI _mapUI;

  _DeviceItemPageState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      test();
    });
  }

  void close() async {
    await _item.item.device.disconnect();
    Future.delayed(const Duration(microseconds: 100), () {
      pop();
      show("连接设备", "连接失败");
    });
  }

  @override
  void dialogClose() {
    if (!_init) {
      close();
    }
  }

  @override
  void mapClose() {
    _isMap = false;
  }

  void showLoadingDialog() async {
    var dialog = LoadingDialog(this, content: "连接设备中");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }

  hideLoadingDialog() {
    Navigator.of(context).pop();
  }

  @override
  void data(String data) {
    if (data.startsWith("a1:")) {
      var temp = double.parse(data.substring(2));
      _a1.addData(temp);
      setState(() {
        _a1.update();
      });
      if (_isMap) {
        _mapUI.data = temp;
      }
    } else if (data.startsWith("a2:")) {
      var temp = double.parse(data.substring(2));
      _a2.addData(temp);
      setState(() {
        _a2.update();
      });
      if (_isMap) {
        _mapUI.data1 = temp;
      }
    } else if (data.startsWith("a3:")) {
      _a3.addData(double.parse(data.substring(2)));
      setState(() {
        _a3.update();
      });
    } else if (data.startsWith("a4:")) {
      _a4.addData(double.parse(data.substring(2)));
      setState(() {
        _a4.update();
      });
    } else if (data.startsWith("a5:")) {
      _a5.addData(double.parse(data.substring(2)));
      setState(() {
        _a5.update();
      });
    }
  }

  void test() async {
    showLoadingDialog();
    if (widget.res == null) {
      _init = true;
      hideLoadingDialog();
      return;
    }
    _item = BluetoothItem(widget.res!, this);
    if (!await _item.ok) {
      pop();
      show("不支持的设备", "你链接的不是指定的设备");
    }
    hideLoadingDialog();
    _init = true;
  }

  double _angle = 0;

  void _test() {
    _a1.addData(_angle ++);
    if(_angle >= 360)
      _angle = 0;
    setState(() {
      _a1.update();
    });
    _a2.addData(Random().nextDouble() * 360);
    setState(() {
      _a2.update();
    });
    _a3.addData(Random().nextDouble() * 360);
    setState(() {
      _a3.update();
    });
    _a4.addData(Random().nextDouble() * 360);
    setState(() {
      _a4.update();
    });
    _a5.addData(Random().nextDouble() * 360);
    setState(() {
      _a5.update();
    });
  }

  void _map() {
    _test();
    // _isMap = true;
    // goto(_mapUI = MapUI(this));
    if (_isMap) {
      Future.delayed(const Duration(milliseconds: 10), () {
        _mapUI.data = _a1.data;
        _mapUI.data1 = _a2.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _a1.getItem(),
            _a2.getItem(),
            _a3.getItem(),
            _a4.getItem(),
            _a5.getItem()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _map,
        tooltip: 'Increment',
        child: const Icon(Icons.map),
      ),
    );
  }

  @override
  void dispose() async {
    await _item.item.device.disconnect();
    super.dispose();
  }
}
