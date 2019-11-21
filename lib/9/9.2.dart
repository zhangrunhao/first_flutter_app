import 'package:flutter/material.dart';

class AnimationBasicStructionRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("9.2"),),
      body: Test1(),
    );
  }
}

class Test1 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Test1State();
  }
}

// 需要继承TickerProvider
// 如果有多个AnimationController, 则应该使用TickerProviderStateMixin
class _Test1State extends State<Test1> with SingleTickerProviderStateMixin {

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linear  
    );
    animation = Tween(
      begin: 0.0,
      end: 300.0,
    )
    .animate(animation);
    // TODO: 这里为什么需要两个.
    // ..addListener(() {
    //   setState(() {
    //   });
    // });

    // 动画的状态监听器
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) { // 在起始点停止
        controller.forward();
      }
    });

    controller.forward();
  }

  @override
  void dispose() {
    // 销毁资源
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GrowTranstion(
      child: Image.asset('images/aliya.jpg'),
      animation: animation,
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return AnimatedImage(animation: animation,);
    /**
     * 1. 不必显示添加帧监听器, 然后调用setState, 与AnimatedWidget相同
     * 2. 动画的构建范围减小. 不必在父级上下文进行构建
     * 3. 可以封装常见的动画
     */
    // return AnimatedBuilder( // 避免不必要的builder
    //   animation: animation,
    //   /**
    //    * TODO: 这里没有理解, 不明白在解释什么
    //    * 外部引用child传递给AnimatedBuilder之后, AnimatedBuilder再传递给匿名构造器, 然后该对象用作其子对象
    //    */
    //   child: Image.asset('images/aliya.jpg'),
      // builder: (BuildContext ctx, Widget child) {
      //   return Center(
      //     child: Container(
      //       width: animation.value,
      //       height: animation.value,
      //       child: child,
      //     ),
      //   );
      // },
    // );
  // }
}

class GrowTranstion extends StatelessWidget {
  // TODO: 什么时候有super()之类的?
  GrowTranstion({
    this.child,
    this.animation
  });

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        child: child,
        animation: animation,
        builder: (BuildContext ctx, Widget child) {
          return Center(
            child: Container(
              width: animation.value,
              height: animation.value,
              child: child,
            ),
          );
        },
      ),
    );
  }
}

// AnimatedWidget封装了setState细节, 并允许将widget抽离出来
class AnimatedImage extends AnimatedWidget {
  AnimatedImage({
    Key key,
    Animation<double> animation,
  }) : super(
    key: key,
    listenable: animation,
  );

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Image.asset(
        'images/aliya.jpg', 
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}
