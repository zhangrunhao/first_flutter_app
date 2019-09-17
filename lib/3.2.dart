import 'package:flutter/material.dart';
void main() {
 runApp(MyApp()); 
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3.2',
      home: Scaffold(
        appBar: AppBar(
          title: Text('3.2'),
        ),
        body: TapBoxA(),
      ),
    );
  }
}

// 自身管理状态
class TapBoxA  extends StatefulWidget{
  const TapBoxA({
    Key key
  }):super(key: key);
  @override
  _TapBoxAState createState () => new _TapBoxAState();
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