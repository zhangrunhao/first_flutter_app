import 'package:flutter/material.dart';

class ContainerRoute extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('5.5'),),
      body: TestContainerMarginAndPaddingBox(),
    );
  }
}

/* 
 * Container是组合类容器, 并不对应renderObject
 * 例如: DecoratedBox, ConstraineBox, Transform, Padding, Algin等组件组合
 * 容器的大小通过width和height指定, 也可以使用constrains进行限制, 同事存在时, width和height优先
 * color和decoration互斥
*/
class TestContainerBox extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50, left: 120),
      constraints: BoxConstraints.tightFor(width: 200, height: 150),
      decoration: BoxDecoration(
        gradient: RadialGradient( // 背景径向渐变
          colors: [Colors.red, Colors.orange],
          center: Alignment.topLeft,
          radius: .98
        ),
        boxShadow: [ // 卡片阴影
          BoxShadow(
            color: Colors.black54,
            offset: Offset(2.0, 2.0),
            blurRadius: 4.0
          )
        ]
      ),
      transform: Matrix4.rotationZ(.2), // 卡片倾斜变化
      alignment: Alignment.center, // 卡片文字居中
      child: Text('5.2', style: TextStyle(color: Colors.white, fontSize: 40),),
    );
  }
}

class TestContainerMarginAndPaddingBox extends StatelessWidget {
  Widget build(BuildContext context) {
    // Container内部的margin和padding都是通过 Padding进行实现的
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20),
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.orange),
            child: Text('Hello World'),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.orange),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text('Hello World'),
          ),
        )
      ],
    );
    // return Column(
    //   children: <Widget>[
    //     Container(
    //       margin: EdgeInsets.all(20),
    //       color: Colors.orange,
    //       child: Text('Hello World'),
    //     ),
    //     Container(
    //       padding: EdgeInsets.all(20),
    //       color: Colors.orange,
    //       child: Text('Hello World'),
    //     )
    //   ],
    // ); 
  }
}