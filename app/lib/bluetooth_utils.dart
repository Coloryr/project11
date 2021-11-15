import 'dart:io';

import 'package:app/main.dart';
import 'package:flutter_blue/flutter_blue.dart';

abstract class ScanRes {
  void res(List<ScanResult> list);
}

class BluetoothUtils {
  static final FlutterBlue _flutterBlue = FlutterBlue.instance;
  static bool _enable = false;

  static bool get enable {
    initBlue();
    return _enable;
  }

  static void initBlue() async {
    if (!await _flutterBlue.isAvailable) {
      show("蓝牙不支持", "你的设备不支持蓝牙设备，无法使用功能");
      return;
    }
    if (!await _flutterBlue.isOn) {
      show("蓝牙未开启", "你的设备未启动蓝牙，无法使用功能");
      return;
    }

    _enable = true;
  }

  static void scan(ScanRes res) async {
    _flutterBlue.scanResults.listen(res.res);
    _flutterBlue.startScan(timeout: const Duration(seconds: 12));
    _flutterBlue.stopScan();
  }
}

class ServerUUID {
  static final Guid server = Guid("6E400001-B5A3-F393-E0A9-E50E24DCCA9E");
  static final Guid tx = Guid("6E400003-B5A3-F393-E0A9-E50E24DCCA9E");
  static final Guid rx = Guid("6E400002-B5A3-F393-E0A9-E50E24DCCA9E");
}

abstract class OnData {
  void data(String data);
}

class BluetoothItem {
  ScanResult item;
  OnData data;
  late BluetoothService service;
  BluetoothCharacteristic? tx;
  BluetoothCharacteristic? rx;

  BluetoothItem(this.item, this.data);

  Future<bool> get ok async {
    if (!await connect()) {
      return false;
    }
    if (!test()) {
      return false;
    }
    await tx!.setNotifyValue(true);
    tx!.value.listen((value) {
      data.data(systemEncoding.decoder.convert(value));
    });
    return true;
  }

  Future<bool> connect() async {
    var res = await item.device.state.first;
    if (res != BluetoothDeviceState.connected) {
      await item.device.connect(autoConnect: false);
    }
    List<BluetoothService> services = await item.device.discoverServices();

    for (var item1 in services) {
      if (item1.uuid == ServerUUID.server) {
        service = item1;
        return true;
      }
    }

    return false;
  }

  bool test() {
    List<BluetoothCharacteristic> characteristics = service.characteristics;
    for (var item in characteristics) {
      if (item.uuid == ServerUUID.rx) {
        rx = item;
      } else if (item.uuid == ServerUUID.tx) {
        tx = item;
      }
    }
    return rx != null && tx != null;
  }

  void write(String data) {
    tx?.write(systemEncoding.encoder.convert(data));
  }
}
