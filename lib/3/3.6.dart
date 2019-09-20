import 'package:flutter/material.dart';

class SwitchAndCheckBoxTestRoute extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3.6'),
      ),
      body: SwitchAndCheckBoxTest(),
    );
  }
}
class SwitchAndCheckBoxTest extends StatefulWidget {
  _SwitchAndCheckBoxTestRouteState createState () =>  _SwitchAndCheckBoxTestRouteState();
}

class _SwitchAndCheckBoxTestRouteState extends State {

  bool _switchSelected = true;
  bool _checkboxSelected = true;

  @override
  Widget build (BuildContext context) {
    return Column(
      children: <Widget>[
        Switch(
          value: _switchSelected, // 当前状态
          onChanged: (value) {
            //  重新构建页面
            setState(() {
              _switchSelected = value;
            });
          },
        ),
        Checkbox(
          tristate: true, // 为true时, 有三种状态, true, false 和 null
          value: _checkboxSelected,
          activeColor: Colors.red, // 选中时的颜色
          onChanged: (value) {
            setState(() {
              _checkboxSelected = value;
            });
          },
        ),
      ],
    );
  }
}