import 'package:flutter/material.dart';

class WillPopScopeTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WillPopScopeRouteState();
  }
}

class _WillPopScopeRouteState extends State<WillPopScopeTestRoute> {

  DateTime _lastPressAt; // 上次点击的时间

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // 第一次按
        // 或者是间隔小于1秒
        if (_lastPressAt == null || DateTime.now().difference(_lastPressAt) > Duration(seconds: 1)) {
          _lastPressAt = DateTime.now();
          return false;
        }
        return true;
      },
      child: Container(
        alignment: Alignment.center,
        child: Text('1秒内连续按两次'),
      ),
    );
  }
}
