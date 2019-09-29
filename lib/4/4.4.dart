import 'package:flutter/material.dart';

class TestWrapAndFlowLayoutRoute extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('4.4')),
      body: TestFlow(),
    );
  }
}

class TestWrap extends StatelessWidget {
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // 主轴方向间距
      runSpacing: 4.0, // 纵轴方向间距
      alignment: WrapAlignment.center, // 沿主轴方向居中
      children: <Widget>[
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A'),),
          label: Text('Hamilton'),
        ),
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('L'),),
          label: Text('Lafayette'),
        ),
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('M'),),
          label: Text('Mulligan'),
        ),
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('L'),),
          label: Text('Laurens'),
        ),
      ],
    );
  }
}

class TestFlow extends StatelessWidget {
  Widget build (BuildContext context) {
    return Flow(
      delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
      children: <Widget>[
        Container(width: 80.0, height: 80.0, color: Colors.red,),
        Container(width: 80.0, height: 80.0, color: Colors.green,),
        Container(width: 80.0, height: 80.0, color: Colors.grey,),
        Container(width: 80.0, height: 80.0, color: Colors.cyan,),
        Container(width: 80.0, height: 80.0, color: Colors.pink,),
        Container(width: 80.0, height: 80.0, color: Colors.blue,),
        Container(width: 80.0, height: 80.0, color: Colors.brown,),
        Container(width: 80.0, height: 80.0, color: Colors.yellow,),
        Container(width: 80.0, height: 80.0, color: Colors.orange,),
        Container(width: 80.0, height: 80.0, color: Colors.indigo),
        Container(width: 80.0, height: 80.0, color: Colors.indigo),
      ],
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  // margin = EdgeInsets.all(10.0)
  // 从代码看: EdgeInsets.zero = EdgeInsets.only({
  //   this.left = 0.0,
  //   this.top = 0.0,
  //   this.right = 0.0,
  //   this.bottom = 0.0,
  // })
  // TODO: 不理解在什么样的情况下, 设置了 EdgeInsets.all(10.0)
  EdgeInsets margin = EdgeInsets.zero;

  TestFlowDelegate({
    this.margin
  });

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }

  @override
  Size getSize(BoxConstraints constraints) {
    EdgeInsets.all(10.0);
    // Flow 不能自适应子weidget的大小, 需要给定一个固定大小
    return Size(double.infinity, 1000.0);
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    // 计算每一widget位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(
          i,
          transform: new Matrix4.translationValues(x, y, 0.0)
        );
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        // 控制子widget(有优化)
        context.paintChild(
          i,
          transform: new Matrix4.translationValues(x, y, 0.0)
        );
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }
}

