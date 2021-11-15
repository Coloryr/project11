import 'package:flutter/material.dart';

abstract class OnDialogClose{
  void dialogClose();
}

class LoadingDialog extends StatefulWidget {
  final Color _valueColor;
  final String _content;
  bool _isActive = false;
  final OnDialogClose _close;
  LoadingDialog(
      this._close,
      {Key? key, Color valueColor = Colors.black, String content = "加载中..."})
      : _valueColor = valueColor,
        _content = content,
        super(key: key);

  @override
  _LoadingDialogState createState() => _LoadingDialogState();

  bool get load {
    return _isActive;
  }
}

class _LoadingDialogState extends State<LoadingDialog> {

  void initState() {
    // loading弹窗当前为活跃界面
    super.initState();
    widget._isActive = true;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      // 设置透明
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.white,
          child: Stack(
            children: [
              Align(
                child: CircularProgressIndicator(
                  strokeWidth: 4.0,
                  valueColor: AlwaysStoppedAnimation(widget._valueColor),
                ),
                alignment: Alignment.center,
              ),
              Align(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: Text(widget._content),
                ),
                alignment: Alignment.bottomCenter,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget._isActive = false;
    widget._close.dialogClose();
  }
}