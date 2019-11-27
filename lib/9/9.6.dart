import 'package:flutter/material.dart';

class AnimatiedSwitcherCounterRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("9.6"),),
      body: Test1(),
    );
  }
}

class Test1 extends StatefulWidget {
  @override
  _Test1State createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher( // 新旧元素交替时, 执行动画
            duration: Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              var tween = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
              // return MySlideTransiton(
              //   child: child,
              //   position: tween.animate(animation),
              // );
              return SlideTransitionX(
                child: child,
                position: animation,
                direction: AxisDirection.up,
              );
            },
            child: Text(
              '$_count',
              // 显示的指定key, 不同的key会被认为是不同的Text, 才能执行动画
              key: ValueKey<int>(_count),
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          RaisedButton(
            child: Text('+1'),
            onPressed: () {
              setState(() {
                _count += 1;
              });
            },
          ),
        ],
      ),
    );
  }
}

// TODO:  不明白这里的运行过程?

class MySlideTransiton extends AnimatedWidget {
  MySlideTransiton({
    Key key,
    @required Animation<Offset> position,
    this.transformHitTests = true,
    this.child,
  }) : assert(position != null), super(key: key, listenable: position);
  
  Animation<Offset> get postion => listenable;
  final bool transformHitTests;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Offset offset = postion.value;
    // 动画反向执行的时候, 调整X偏移, 实现"从左边滑出隐藏"
    if (postion.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX({
    Key key,
    @required Animation<double> position,
    this.transformHitTests = true,
    this.direction = AxisDirection.down,
    this.child,
  }) : assert(position != null), super(key: key, listenable: position) {
    // 偏移在内部处理
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: Offset(1, 1), end: Offset(0, 0));
        break;
      default:
    }
  }

  Animation<double> get position => listenable;
  final bool  transformHitTests;
  final Widget child;
  // 退出方向
  final AxisDirection direction;
  Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

