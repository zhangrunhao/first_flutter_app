import 'package:flutter/material.dart';

class PointerEventRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('8.1'),),
      body: Test3(),
    );
  }
}

class Test3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Listener(
      child: IgnorePointer( // 两个都不输出
      // child: AbsorbPointer( // 只输出out
        child: Listener(
          child: Container(
            color: Colors.red,
            width: 200,
            height: 100,
          ),
          onPointerDown: (e) => print("in"),
        ),
      ),
      onPointerDown: (e) => print("out"),
    );
  }
}

class Test2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Listener(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(300, 200)),
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.blue),
            ),
          ),
          onPointerDown: (event) => print("down0"),
        ),
        Listener(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(200, 100)),
            child: Center(child: Text("左上角200*100范围内非文本区域点击"),),
          ),
          onPointerDown: (event) => print("down1"),
          // TODO: 所有的属性, 在点击文本区域时, 结果全部一致.无法理解属性区别
          // behavior: HitTestBehavior.translucent, // 打印 down1
          // behavior: HitTestBehavior.deferToChild, // down1
          // behavior: HitTestBehavior.opaque, // down1
          // down1
        )
      ],
    );
  }
}

class Test1 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Test1State();
  }
}

class _Test1State extends State<Test1> {
  PointerEvent _event;
  @override
  Widget build(BuildContext context) {
    return Listener(
      child: Container(
        alignment: Alignment.center,
        color: Colors.blue,
        width: 300,
        height: 150,
        // TODO: "?."  "??"  表示什么运算
        child: Text(_event?.toString()??"", style: TextStyle(color: Colors.white),),
      ),
      behavior: HitTestBehavior.deferToChild,
      onPointerDown: (PointerEvent event) {
        setState(() {
          _event = event;
        });
      },
      onPointerMove: (PointerEvent event) {
        setState(() {
          _event = event;
        });
      },
      onPointerUp: (PointerEvent event) {
        setState(() {
          _event = event;
        });
      },
    );
  } 
}
