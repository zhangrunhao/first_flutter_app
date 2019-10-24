import 'package:flutter/material.dart';
import 'dart:math' as math;

class TransformRoute extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('5.4')),
      body: Container(
        margin: EdgeInsets.all(20),
        child: TestNoted(),
      ),
    );
  }
}

class TestTransformBox extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(120),
      color: Colors.black,
      child: Transform(
        // TODO: 不理解什么是4d变化, 矩阵相关变换
        alignment: Alignment.topRight, // 坐标系原点的对齐方式
        // 矩阵变化发生在绘制时, 无需重新布局和构建
        transform: Matrix4.skewY(0.3),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.deepOrange,
          child: const Text('Apartment for rent'),
        ),
      ),
    );
  }
}

class TestParallel extends StatelessWidget {
  Widget build(BuildContext context) {
    return DecoratedBox(
      // 默认原点是左上角
      decoration: BoxDecoration(color: Colors.red),
      // child: Transform.translate(
      //   offset: Offset(20, 10),
      //   child: Text("Hello world"),
      // ),
      // child: Transform.rotate(
      //   // angle角度, 360度 = 2 pai
      //   angle: math.pi / 2,
      //   child: Text('Rotate'),
      // ),
      child: Transform.scale(
        scale: 1.5,
        child: Text('Scale'),
      ),
    );
  }
}

class TestNoted extends StatelessWidget {
  Widget build (BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Text('Hello World'),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.red),
          // Transform的变换应用在绘制阶段, 并不硬性layout布局阶段
          // 所以不论应用何种变化, 在屏幕上占用的大小, 位置都是不变的
          // 例如`Flow`组件, 便是使用矩阵对这些进行定位的
          // child: Transform.scale(
          //   scale: 1.5,
          //   child: Text('Hello worled'),
          // ),
          // RotatedBox 在Layout布局阶段更改位置, 所有影响其他元素
          child: RotatedBox(
            quarterTurns: 1, // 渲染九十度(1/4圈)
            child: Text('Hello World'),
          ),
        ),
        Text('你好', style: TextStyle(color: Colors.green, fontSize: 18),)
        // 如果先旋转的话, 左上角的位置也就变了, 也就是原点变了, 所以效果不同
        // DecoratedBox(
        //   decoration: BoxDecoration(color: Colors.red),
        //   child: Transform.translate(
        //     offset: Offset(20, 10),
        //     child: Transform.rotate(
        //       angle: math.pi / 2,
        //       child: Text('Hello world'),
        //     ),
        //   ),
        // ),
        // DecoratedBox(
        //   decoration: BoxDecoration(color: Colors.red),
        //   child: Transform.rotate(
        //     angle: math.pi / 2,
        //     child: Transform.translate(
        //       offset: Offset(20, 10),
        //       child: Text('Hello world'),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
