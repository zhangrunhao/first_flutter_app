import 'package:flutter/material.dart';

// Flex: direction: 方向, 其他就是Row / Column

class TestFlexAndExpandedRoute extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('4.3'),),
      body: TestFlexLayout(),
    );
  }
}

class TestFlexLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              flex: 1, // 代表比例
              child: Container(
                height: 30.0,
                color: Colors.red,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 30.0,
                color: Colors.green,
              ),
            )
          ],
        ),
        Padding(
          // TODO: 为什么这里可以采用定义变量的方式
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            // TODO: 如果主轴为垂直, 必须给定高度, 为什么宽度就不需要?
            height: 100,
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(height: 80.0, color: Colors.red,),
                ),
                Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 1,
                  child: Container(height: 30.0, color: Colors.green,),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
