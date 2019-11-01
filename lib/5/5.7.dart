import 'package:flutter/material.dart';

class ClipRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('5.7'),),
      body: TestClip(),
    );
  }
}

class TestClip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget avatar = Image.asset('images/aliya.jpg', width: 60,);
    return Center(
      child: Column(
        children: <Widget>[
          avatar,
          ClipOval(child: avatar,), // 剪切为原型
          ClipRRect( // 圆角矩形
            borderRadius: BorderRadius.circular(10),
            child: avatar,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                widthFactor: .1, // 宽度设置为原来的一半
                child: avatar,
              ),
              // Text('你好, 世界', style: TextStyle(color: Colors.green),)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRect( // 将溢出部分
                child: Align(
                  alignment: Alignment.topLeft,
                  widthFactor: .5,
                  child: avatar,
                ),
              ),
              Text('你好, 世界', style: TextStyle(color: Colors.green),)
            ],
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: ClipRect(
              clipper: MyClip(),
              child: avatar,
            ),
          ),
        ],
      ),
    );
  }
}

class MyClip extends CustomClipper<Rect> {
  // getClip获取剪裁窗口
  @override
  Rect getClip(Size size) => Rect.fromLTWH(10, 15, 40, 30);

  // shouldClip是否重新重新裁剪
  // 如果在应用中裁剪区域始终不会变化, 应该是用false. 避免性能浪费
  // 如果发生变化(例如执行动画), 应该返回true来重新裁剪
  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}
