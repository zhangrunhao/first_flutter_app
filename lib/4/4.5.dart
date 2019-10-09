import 'package:flutter/material.dart';

class TestStackAndPositionedLayoutRoute extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('4.5'),),
      body: TestStackBox(),
    );
  }
}

class TestStackBox extends StatelessWidget {
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center, // 指定未定位或部分定位widget的对齐方式
        fit: StackFit.expand, // 未定位的widget沾满整个容器
        children: <Widget>[
          Container(
            child: Text('Hello world', style: TextStyle(color: Colors.white),),
            color: Colors.red,
          ), 
          Positioned(
            left: 18.0,
            child: Text("I am Jack"),
          ),
          Positioned(
            top: 18.0,
            child: Text("Your friend"),
          )
        ],
      ),
    );
  }
}