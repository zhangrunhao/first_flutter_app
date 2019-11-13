import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_app/8/8.3.dart';

var bus = new EventBus();

class GestureDetectorRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Test5(),
    );
  }
}

class Test5 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Test5State();
  }
}

class _Test5State extends State {
  double _top = 50.0;
  double _left = 20.0;
  @override
  Widget build(BuildContext context) {
    // 每次build都会进行事件的订阅
    var f = (arg) {
      print('login');
      print(arg);
    };
    bus.add('login', f);
    return Stack(
      children: <Widget>[
        RaisedButton(
          child: Text("点击"),
          onPressed: () {
            bus.emit('login', 'aaaaa');
            // bus.off('login', f);
          },
        ),
        Positioned(
          top: _top,
          left: _left,
          child: Listener(
            // 通过Listener直接识别原始指针事件, 解决冲突
            onPointerUp: (d) {
              print("onPointerUp");
            },
            onPointerDown: (d) {
              print("onPointerDown");
            },
            child:  GestureDetector(
              child: CircleAvatar(child: Text("A"),),
              // 手势竞争, 一旦某一方获胜, 会一直按照这一方面进行操作, 直到结束
              // onVerticalDragUpdate: (DragUpdateDetails d) {
              //   setState(() {
              //     _top += d.delta.dy;
              //   });
              // },
              onHorizontalDragUpdate: (DragUpdateDetails d) {
                setState(() {
                  _left += d.delta.dx;
                });
              },
              /**
               * 打印顺序: onTapDown => onHorizontalDragEnd
               * 刚刚按下的时候, 手势没有完整意义, 此时Down胜出
               * 抬起的时候,因为判定为一个拖动动作, onHorizontalDragEnd胜出
               * 通过外部Listener监听解决
               * 
               */
              onHorizontalDragEnd: (DragEndDetails d) {
                print("onHorizontalDragEnd");
              },
              // onTapDown: (d) {
              //   print("onTapDown");
              // },
              // onTapUp: (d) {
              //   print("onTapUp");
              // },
            ),
          )
        )
      ],
    );
  }
}

class Test4 extends StatefulWidget{
  @override
  _Test4State createState() {
    return _Test4State();
  }
}

class _Test4State extends State<Test4> {
  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();
  bool _toggle = false;

  @override
  void dispose() {
    // TODO: 为什么是取消内部计时器?代表了什么含义?
    // GestureRecognizer后一定要dispose, 主要是为了取消内部计时器
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: <InlineSpan>[
            TextSpan(text: "你好世界"),
            TextSpan(
              text: "点我换色",
              style: TextStyle(
                fontSize: 30,
                color: _toggle ? Colors.blue : Colors.red
              ),
              // TODO: 这里".."是什么运算.
              recognizer: _tapGestureRecognizer..onTap = () {
                setState(() {
                  _toggle = !_toggle;
                });
              }
            ),
            TextSpan(text: "你好世界")
          ],
        )
      ),
    );
  }
}

class Test3 extends StatefulWidget{
  @override
  _Test3State createState() {
    return _Test3State();
  }
}

class _Test3State extends State<Test3> {
  double _width = 200;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        // 指定宽度, 高度自适应
        child: Image.asset('images/aliya.jpg', width: _width,),
        onScaleUpdate: (ScaleUpdateDetails d) {
          setState(() {
            // TODO: 可以尝试实现动画
            _width = 200 * d.scale.clamp(.8, 10);
          });
        },
      ),
    );
  }
}

class Test2 extends StatefulWidget {
  @override
  _Test2State createState() {
    return _Test2State();
  }
}

class _Test2State extends State<Test2> with SingleTickerProviderStateMixin{
  double _top = 0.0;
  double _left = 0.0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A"),),
            onPanDown: (DragDownDetails d) {
              // 打印手指按下的位置(相对于屏幕)
              print("用户手指按下: ${d.globalPosition}");
            },
            onPanUpdate: (DragUpdateDetails d) {
              // 手指移动, 重新构建
              setState(() {
                _top  += d.delta.dy;
                // _left += d.delta.dx;
              });
            },
            onPanEnd: (DragEndDetails d) {
              // 打印结束时, 在x, y轴上的速度
              print(d.velocity);
            },
          ),
        ),
      ],
    );
  }
}

class Test1 extends StatefulWidget {
  @override
  _Test1State createState() =>  _Test1State();
}

class _Test1State extends State<Test1> {
  String _operation = "No Gesture detected";
  void updateText(String t) {
    setState(() {
      _operation = t;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => updateText("Tap"),
        onDoubleTap: () => updateText("DoubleTap"),
        onLongPress: () => updateText("LongPress"),
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 200,
          height: 100,
          child: Text(_operation, style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}

