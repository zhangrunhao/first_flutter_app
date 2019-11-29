import 'dart:developer';

import 'package:flutter/material.dart';

class AnimationTransitonCompositonRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("9.7"),),
      body: AnimatedWidgetsTest(),
    );
  }
}

class AnimatedWidgetsTest extends StatefulWidget{
  @override
  _AnimatedWidgetsTestState createState() => _AnimatedWidgetsTestState();
}

class _AnimatedWidgetsTestState extends State<AnimatedWidgetsTest> {
  double _padding = 100;
  var _align = Alignment.topRight;
  double _height = 100;
  double _left = 0;
  Color _color = Colors.red;
  TextStyle _style = TextStyle(
    color: Colors.black,
    fontSize: 20.0,
  );
  Color _decorationColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    var duration = Duration(seconds: 5);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              setState(() {
                _padding = 20;
              });
            },
            child: AnimatedPadding(
              duration: duration,
              padding: EdgeInsets.all(_padding),
              child: Text("AnimatedPadding"),
            ),
          ),
          SizedBox(
            height: 50,
            child: Stack(
              children: <Widget>[
                AnimatedPositioned(
                  duration: duration,
                  left: _left,
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        _left = 100;
                      });
                    },
                    child: Text("AnimatedPositioned"),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 100,
            color: Colors.grey,
            child: AnimatedAlign(
              duration: duration,
              alignment: _align,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    _align = Alignment.center;
                  });
                },
                child: Text("AnimatedAlign"),
              ),
            ),
          ),
          AnimatedContainer(
            duration: duration,
            height: _height,
            color: _color,
            child: FlatButton(
              onPressed: () {
                setState(() {
                  _height = 150;
                  _color = Colors.blue;
                });
              },
              child: Text("AnimatedContainer", style: TextStyle(color: Colors.white),),
            ),
          ),
          AnimatedDefaultTextStyle(
            child: GestureDetector(
              child: Text("hello world"),
              onTap: () {
                setState(() {
                  _style = TextStyle(
                    fontSize: 30.0,
                    color: Colors.blue,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: Colors.blue,
                  );
                });
              },
            ),
            style: _style,
            duration: duration,
          ),
          AnimatedDecoratedBox(
            duration: duration,
            decoration: BoxDecoration(color: _decorationColor),
            child: FlatButton(
              onPressed: () {
                setState(() {
                  _decorationColor = Colors.red;
                });
              },
              child: Text(
                "AnimatedDecoratedBox",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ].map((e) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: e,
          );
        }).toList(),
      ),
    );
  }
}

class Test2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Test2State();
  }
}

class _Test2State  extends State{
  Color _decorationColor = Colors.blue;
  Duration _duration = Duration(seconds: 1);
  @override
  Widget build(BuildContext context) {
    return AnimatedDecoratedBox(
      decoration: BoxDecoration(color: _decorationColor),
      duration: Duration(milliseconds: _decorationColor == Colors.red ? 400 : 2000),
      child: FlatButton(
        onPressed: () {
          setState(() {
            // 如果有反向动画, 那就使用状态的互换
            _decorationColor = _decorationColor == Colors.red ? Colors.blue : Colors.red;
          });
        },
        child: Text("测试", style: TextStyle(color: Colors.white),),
      ),
    );
  }
}



class AnimatedDecoratedBox extends ImplicitlyAnimatedWidget{
  AnimatedDecoratedBox({
    Key key,
    @required this.decoration,
    this.child,
    Curve curve = Curves.linear,
    @required Duration duration,
    // Duration reverseDuration,
  }) : super(
    key: key,
    curve: curve,
    duration: duration,
    // reverseDuration: reverseDuration,
  );

  final BoxDecoration decoration;
  final Widget child;

  @override
  _AnimatedDecoratedBoxState createState() {
    return _AnimatedDecoratedBoxState();
  }
}

// AnimatedWidgetBaseState 继承 ImplicitlyAnimatedWidgetState
// 每一帧都会调用build
class _AnimatedDecoratedBoxState extends AnimatedWidgetBaseState<AnimatedDecoratedBox>{
  DecorationTween _decoration;

  @override
  void forEachTween(visitor) {
    // 在需要更新Tween时, 基类会调用此方法
    // visitor方法用来更新Tween的值
    _decoration = visitor(
      _decoration,
      widget.decoration,
      (value) => DecorationTween(begin: value)
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      // 计算每一帧的decoration状态.
      decoration: _decoration.evaluate(animation),
      child: widget.child,
    );
  }
}


class Test1 extends StatefulWidget{
  @override
  _Test1State createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  Color _decorationColor = Colors.blue;
  Duration duration = Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimateDecoratedBox1(
        duration: duration,
        decoration: BoxDecoration(color: _decorationColor),
        child: FlatButton(
          onPressed: () {
            setState(() {
              _decorationColor = Colors.red; 
            });
          },
          child: Text(
            "AnimatedDecoratedBox",
            style: TextStyle(color: Colors.white), 
          ),
        ),
      ),
    );
  }
}


class AnimateDecoratedBox1 extends StatefulWidget {
  AnimateDecoratedBox1({
    Key key,
    @required this.decoration, // 初始的样式
    @required this.duration, // 过渡时间
    this.child,
    this.curve = Curves.linear,
    // this.reverseDuration,
  });

  final BoxDecoration decoration;
  final Widget child;
  final Duration duration;
  final Curve curve;
  // final Duration reverseDuration;

  @override
  _AnimateDecoratedBox1State createState() => _AnimateDecoratedBox1State();
}

class _AnimateDecoratedBox1State extends State<AnimateDecoratedBox1> with SingleTickerProviderStateMixin {

  @protected
  AnimationController get controller => _controller;
  AnimationController _controller;

  Animation<double> get animation => _animation;
  Animation<double> _animation;

  DecorationTween _tween;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return DecoratedBox(
          decoration: _tween.animate(_animation).value,
          child: widget.child,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      // reverseDuration: widget.reverseDuration,
      vsync: this,
    );
    _tween = DecorationTween(begin: widget.decoration);
    _updateCurve();
  }

  void _updateCurve() {
    // TODO: 不能明白这里进行的意义, 为什么如果curve是空, 就是controller给了animation
    if (widget.curve != null)
      _animation = CurvedAnimation(
        parent: _controller,
        curve: widget.curve
      );
    else
      _animation = _controller;
  }

  @override
  void didUpdateWidget(AnimateDecoratedBox1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 每一次刷新屏幕, 都会更新.
    if (widget.curve!= oldWidget.curve) {
      _updateCurve();
    }
    _controller.duration = widget.duration;
    // _controller.reverseDuration = widget.reverseDuration;
    // TODO: 这都是什么神奇语法?, 越来越看不懂这是在干什么了...
    if (widget.decoration != (_tween.end ?? _tween.begin)) {
      _tween
        ..begin = _tween.evaluate(_animation)
        ..end = widget.decoration;
      _controller
        ..value = 0.0
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}