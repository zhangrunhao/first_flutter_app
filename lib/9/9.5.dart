import 'package:flutter/material.dart';

class StaggerAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("9.5"),),
      body: Test1(),
    );
  }
}

// 先将动画执行的widget分离出来
// TODO: 为什么这个类被标记为不变的, 还是可以继续改变呢? 或者说, 这里为什么会标出一个奇怪的提示.
class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({
    Key key,
    this.controller
  }) : super(key: key) {

    height = Tween<double>(
      begin: .0,
      end: 300.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(.0, .6, curve: Curves.ease)
      ) 
    );

    padding = Tween<EdgeInsets>(
      begin: EdgeInsets.only(left: .0),
      end: EdgeInsets.only(left: 100.0)
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(.6, 1.0, curve: Curves.ease)
      )
    );

    color = ColorTween(
      begin: Colors.green,
      end: Colors.red
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(.0, .6, curve: Curves.ease)
      ) 
    );
  }

  final Animation<double> controller;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  Animation<Color> color;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}

class Test1 extends StatefulWidget {
  @override
  _Test1State createState() => _Test1State();
}

class _Test1State extends State<Test1> with TickerProviderStateMixin{
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this
    );
  }

  Future<Null> _playAnimation() async {
    // TODO: try on..  是什么用法?
    try {
      // 先正向执行动画
      await _controller.forward().orCancel;
      // 再执行反向动画
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceld, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _playAnimation();
      },
      child: Center(
        child: Container(
          width: 300.0,
          height: 300.0,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.1),
            border: Border.all(
              color: Colors.black.withOpacity(.5)
            )
          ),
          child: StaggerAnimation(
            controller: _controller,
          ),
        ),
      ),
    );
  }
}
