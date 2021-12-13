import 'dart:async';

import 'package:app/bluetooth_utils.dart';
import 'package:app/ui/device_item.dart';
import 'package:app/ui/device_list_item.dart';
import 'package:app/ui/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../main.dart';

class DeviceListUI extends StatefulWidget {
  const DeviceListUI({Key? key}) : super(key: key);

  final String _title = "设备列表";

  @override
  State<DeviceListUI> createState() => _DeviceListPageState();
}

abstract class OnClick {
  void click(ScanResult item);
}

class _DeviceListPageState extends State<DeviceListUI>
    implements ScanRes, OnClick, OnDialogClose {
  final List<Widget> _widgets = [];
  final List<ScanResult> _addItem = [];
  bool visible = false;

  _DeviceListPageState() {
    Future.delayed(const Duration(microseconds: 10), () {
      _res();
    });
  }

  @override
  void res(List<ScanResult> list) {
    for (ScanResult item in list) {
      if (_addItem.contains(item)) {
        continue;
      }
      if (item.device.type == BluetoothDeviceType.unknown) {
        continue;
      }
      _addItem.add(item);
      var item1 = DeviceListItem(item, this);
      setState(() {
        _widgets.add(item1);
      });
    }
  }

  @override
  void click(ScanResult item) {
    goto(DeviceItemUI(item, this));
  }

  @override
  void dialogClose() {
    Future.delayed(const Duration(microseconds: 10), () {
      _res();
    });
  }

  void _scan() {
    if (!BluetoothUtils.enable) {
      return;
    }
    setState(() {
      visible = true;
    });
    BluetoothUtils.scan(this);
    Future.delayed(const Duration(seconds: 12), () {
      setState(() {
        visible = false;
      });
    });
  }

  void _res() {
    _addItem.clear();
    setState(() {
      _widgets.clear();
    });
    _scan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: ListView(
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: visible ? 1.0 : 0.0,
            child: Container(
              height: visible ? 60 : 0,
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: const Align(
                child: CircularProgressIndicator(
                  strokeWidth: 4.0,
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                ),
                alignment: Alignment.center,
              ),
            ),
          ),
          ListView.builder(
            itemCount: _widgets.length,
            itemBuilder: (context, index) {
              return _widgets[index];
            },
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _res,
        tooltip: 'Scan',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
