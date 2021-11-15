import 'package:app/ui/device_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_svg/svg.dart';

import '../main.dart';
import 'device_list.dart';

class DeviceListItem extends StatelessWidget {
  ScanResult name;
  OnClick top;

  DeviceListItem(this.name,this.top, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset("images/svg/blue.svg",
          width: 50, height: 50, color: Colors.black),
      title: Text(name.device.name, style: const TextStyle(color: Colors.black, fontSize: 26)),
      onTap: () => top.click(name),
    );
  }
}
