import 'package:app/bluetooth_utils.dart';
import 'package:app/ui/device_item.dart';
import 'package:app/ui/device_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  BluetoothUtils.initBlue();
}

void pop() {
  Navigator.pop(app);
}

void goto(Widget widget) {
  Navigator.push(app, CupertinoPageRoute(builder: (context) => widget));
}

late BuildContext app;

void show(String title, String info) {
  showDialog(
    context: app,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: [Text(info)],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('确定'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    app = context;
    return const Scaffold(
        body: SafeArea(
      child: DeviceItemUI(null, null),
    ));
  }
}
