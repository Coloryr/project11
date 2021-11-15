import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_svg/svg.dart';

import 'device_list.dart';

class DeviceListItem extends StatelessWidget {
  final ScanResult _name;
  final OnClick _top;

  const DeviceListItem(this._name, this._top, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset("images/svg/blue.svg",
          width: 50, height: 50, color: Colors.black),
      title: Text(_name.device.name,
          style: const TextStyle(color: Colors.black, fontSize: 26)),
      onTap: () => _top.click(_name),
    );
  }
}
