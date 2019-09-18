
import 'package:flutter/material.dart';

void main () {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build (BuildContext context) {
    return MaterialApp(
      title: '3.3',
      home: Scaffold(
        appBar: AppBar(title: Text('3.3'),),
        body: ParentText(),
      ),
    );
  }
}

class ParentText extends StatelessWidget {
  Widget build (BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        fontFamily: 'IndieFlower',
        color: Colors.red
      ),
      child: TestTextClass(),
    );
  }
}

class TestTextClass extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Container(
      width: 400,
      child: Column(
        children: <Widget>[
          Container(
            width: 300,
            child: Text(
              'Hello World',
              textAlign: TextAlign.right,
            ),
          ),
          Text(
            'Hello i am jack, who are you?' * 4,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Hello World',
            textScaleFactor: 1.5, // 根据系统字体大小进行缩放比例控制
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18, // 不会跟随系统字体大小变化
              height: 1.2,
              fontFamily: 'Courier',
              // TODO: .. 是个什么写法
              background: new Paint()..color = Colors.yellow,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dashed,
            ),
          ),
          Text.rich(TextSpan(
              children: [
                TextSpan(
                  text: 'Home: '
                ),
                TextSpan(
                  text: 'https://baidu.com',
                  style: TextStyle(
                    color: Colors.blue
                  ),
                  // TODO: 未能解释这个手势操作, 最后发现必须调用dispose释放资源, 然后就必须在State类中
                  // recognizer: _tapGestureRecognizer
                ),
              ]
            )),
        ],
      )
    );
  }
}
