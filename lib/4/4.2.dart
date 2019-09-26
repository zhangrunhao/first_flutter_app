import 'package:flutter/material.dart';

class TestRowAndColumnRoute extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('4.2'),),
      body: TestNestColumnWidget(),
    );
  }
}

// 两层Row或者Column嵌套, 只有最外层可以占用尽可能大的空间
// TODO:  如果是Row和Column相互嵌套呢?
class TestNestColumnWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max, // 有效, 外层的Column为整个屏幕
          children: <Widget>[
            Expanded( // 可以使用Expand组件, 解决内部最大高度无效的情况, 不需要再设置最大高度即可
              child: Container(
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.max, // 无效, 内层Column高度为实际高度
                  children: <Widget>[
                    Text('hello world'),
                    Text('I am jack')
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TestColumnWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return ConstrainedBox(
      // 使用强制盒子, 使用double.infinity让宽度占用尽可能多的空间
      constraints: BoxConstraints(minWidth: double.infinity),
      child: Column( // 总宽度, 取决于最大子元素
        // 纵轴居中: 也就是水平居中
        crossAxisAlignment: CrossAxisAlignment.center,
        // 未指定mainAxisSize, 默认max, 即为屏幕高度
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(' Hi '),
          Text(' World ')
        ],
      ),
    );
  }
}

class TestRowWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      // 测试Row对齐方式, 排除Column默认居中对齐的干扰
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          // 主轴对齐方式:  居中对齐
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(' hello world '),
            Text(' i am jack ')
          ],
        ),
        Row(
          // 主轴宽度: 最小宽度
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(' hello world '),
            Text(' i am jack ')
          ],
        ),
        Row(
          // 主轴对齐方式: end, 就是目标方向对齐, 目标为左, 即为左对齐
          mainAxisAlignment: MainAxisAlignment.end,
          // 文本方向: 从右向左
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Text(' hello world '),
            Text(' i am jack ')
          ],
        ),
        Row(
          // 纵轴对齐方向: start, 起始方向
          crossAxisAlignment: CrossAxisAlignment.start,
          // 向上的方向
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            Text(' hello world ', style: TextStyle(fontSize: 30),),
            Text(' i am jack ')
          ],
        )
      ],
    );
  }
}
