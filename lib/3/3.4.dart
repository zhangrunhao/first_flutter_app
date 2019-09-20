import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  Widget build (BuildContext context) {
    return MaterialApp(
      title: '3.4',
      home: Scaffold(
        appBar: AppBar(
          title: Text('3.4'),
        ),
        body: TestButtonWidget(),
      ),
    );
  }
}
class TestButtonWidget extends StatelessWidget {
  Widget build (BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text('RaisedButton'),
          onPressed: () {},
        ),
        FlatButton(
          child: Text('FlatButton'),
          onPressed: () {},
        ),
        OutlineButton(
          child: Text('OutlineButton'),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.thumb_up),
          onPressed: () {},
        ),
        RaisedButton.icon(
          icon: Icon(Icons.send),
          label: Text('发送'),
          onPressed: () {},
        ),
        // FlatButton( 普通的, 不会上升的按钮, 没有阴影
        RaisedButton( // 有默认的阴影
          color: Colors.blue,
          // color: Color(0x000000), // 透明处理
          highlightColor: Colors.blue[700],
          colorBrightness: Brightness.dark, // 主题颜色是深色, 按钮的文字颜色就是浅色
          splashColor: Colors.grey,
          child: Text('Submit'),
          shape: RoundedRectangleBorder( // 可以指定外观
            borderRadius: BorderRadius.circular(20.0)
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}