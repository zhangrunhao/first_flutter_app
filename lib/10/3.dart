import 'package:flutter/material.dart';

class ComposeInstanceTurnBoxRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("10.3"),),
      body: Test1(),
    );
  }
}


class MyRichText extends StatefulWidget{
  MyRichText({
    Key key,
    this.text,
    this.linkStyle,
  }) : super(key: key);

  final String text;
  final TextStyle linkStyle;

  @override
  _MyRichTextState createState() => _MyRichTextState();
}

class _MyRichTextState  extends State<MyRichText>{
  // 1. 解析字符串"text", 生成TextSpan缓存起来
  // 2. 在build中返回最终的样式
  TextSpan _textSpan;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: _textSpan,
    );
  }

  TextSpan parseText(String text) {
    // 耗时操作, 解析文本字符串,  构建出TextSpan
    // ...
  }
  
  @override
  void initState() { // 防止每一次都进行解析, 所以在这里进行缓存
    _textSpan = parseText(widget.text);
    super.initState();
  }

  @override
  // 这里很重要, 就是组件更新时是否需要同步
  void didUpdateWidget(MyRichText oldWidget) { // 防止传入的text变化, 无法进行build更新
    if (widget.text != oldWidget.text) {
      _textSpan = parseText(widget.text);
    }
    super.didUpdateWidget(oldWidget);
  }
}


class Test1 extends StatefulWidget{
  @override
  _Test1State createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  double _turns = .0;
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          TurnBox(
            turns: _turns,
            speed: 500,
            child: Icon(Icons.refresh, size: 50,),
          ),
          TurnBox(
            turns: _turns,
            speed: 500,
            child: Icon(Icons.refresh, size: 150.0,),
          ),
          RaisedButton(
            child: Text("顺时针选择1/5圈"),
            onPressed: () {
              setState(() {
                _turns += .2;
              });
            },
          ),
          RaisedButton(
            child: Text("逆时针选择1/5圈"),
            onPressed: () {
              setState(() {
                _turns -= .2;
              });
            },
          )
        ],
      ),
    );
  }
}

class TurnBox extends StatefulWidget {
  TurnBox({
    Key key,
    this.turns = .0, // 旋转的圈数
    this.speed = 200, // 过渡动画总时长
    this.child
  });

  final double turns;
  final int speed;
  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return _TurnBoxState();
  }
}

class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin{
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: -double.infinity,
      upperBound: double.infinity
    );
    _controller.value = widget.turns;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  通过RotationTransition和child实现旋转
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 判断角度是否发生了变化, 变化即执行动画
    // TODO: 不能理解为什么这里的如何进行的. turns代表圈数?
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(
        widget.turns,
        duration: Duration(milliseconds: widget.speed??200),
        curve: Curves.easeOut
      );
    }
  }
}
