import 'dart:ffi';

import 'package:flutter/material.dart';
void main() {
 runApp(MyApp()); 
}
class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3.2',
      home: Scaffold(
        appBar: AppBar(
          title: Text('3.2'),
        ),
        // body: TapBoxA(),
        body: ParentWidgetC()
      ),
    );
  }
}

// 自身管理状态
class TapBoxA  extends StatefulWidget{
  _TapBoxAState createState () => _TapBoxAState();
}

class _TapBoxAState extends State {
  
  bool _active = false;

  void _handleTap () {
    setState(() {
      _active = !_active;
    });
  }

  Widget build (BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            _active ? 'Active' : 'Inactive',
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
            ),
          ),
        ),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: _active ? Colors.lightBlue[700] : Colors.grey,
        ),
      ),
    );
  } 
}

// 父组件管理

class ParentWidget extends StatefulWidget {
  createState () => _ParentWidgetState();
}
class _ParentWidgetState extends State {
  bool _active = false;
  void _handleTapBoxChanged (bool value) {
    setState(() {
      _active = value;
    });
  }
  Widget build(BuildContext context) {
    return Container(
      child: TapBoxB(
        active: _active,
        onChanged: _handleTapBoxChanged,
      ),
    );
  }
}

class TapBoxB extends StatelessWidget {
  TapBoxB({
    Key key,
    this.active: false,
    @required this.onChanged
  }):super(key: key);

  final bool active;
  final onChanged;


  Widget build (BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: 为什么一定要把更改状态的逻辑放到子组件, 不能放到父组件???
        onChanged(!active);
      },
      child: Container(
        width: 200,
        height: 200,
        decoration: new BoxDecoration(
          color: active ? Colors.lightBlue[700] : Colors.grey[600],
        ),
        child: Center(
          child: Text(
            active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ),
    );
  }
}


// 混合管理


class ParentWidgetC extends StatefulWidget{
  _ParentWidgetCState createState () => _ParentWidgetCState();
}
class _ParentWidgetCState extends State {
  bool _active = false;
  void _handleTapboxChanged(bool val) {
    setState(() {
      _active = val;
    });
  }
  Widget build(BuildContext context) {
    return Container(
      child: TapBoxC(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

class TapBoxC extends StatefulWidget {
  TapBoxC({
    Key key,
    this.active = false,
    @required this.onChanged
  }):super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  _TapBoxCState createState () {
    return new _TapBoxCState();
  }
}

// TODO: 后面这个`<>`代表什么, 为什么可以直接使用TapBoxC类中的变量
class _TapBoxCState extends State<TapBoxC> {

  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }
  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }
  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }
  void _handleTap() {
    widget.onChanged(!widget.active);
  }
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTapDown: _handleTapDown, // 处理按下事件
      onTapUp: _handleTapUp, // 处理抬起事件
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: widget.active ? Colors.lightBlue[700] : Colors.grey[600],
          border: _highlight ? Border.all(
            color: Colors.teal[700],
            width: 10
          ) : null,
        ),
        child: Center(
          child: Text(
            widget.active ? 'Acitive' : 'Inactive',
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        )
      ),
    );
  }
}