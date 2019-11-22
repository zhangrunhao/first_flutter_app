import 'package:flutter/material.dart';

class CustomRouteTransitionAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("9.3"),),
      body: Test1()
    );
  }
}

class Test1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text("测试自定义路由动画"),
        onPressed: () {
          Navigator.push(
            context,
            FadeRoute(builder: (context) {
              return Scaffold(appBar: AppBar(title: Text("new Page"),),);
            })
          );
          // 使用PageRouteBuilder过渡路由
          // Navigator.push(
          //   context,
          //   PageRouteBuilder(
          //     transitionDuration: Duration(milliseconds: 500),
          //     pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
          //       return FadeTransition(
          //         opacity: animation,
          //         child: Scaffold(
          //           appBar: AppBar(title: Text("new Page"),),
          //         ),
          //       );
          //     }
          //   )
          // );
        },
      ),
    );
  }
}

// 自定义实现过渡路由
class FadeRoute extends PageRoute {

  FadeRoute({
    @required this.builder,
    this.transitionDuration = const Duration(milliseconds: 1000),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    // 路由激活时候打开新的路由
    if (isActive) {
      return FadeTransition(
        opacity: animation,
        child: builder(context),
      );
    } else {
      // TODO: 这里为什么返回一个填充? 边距为0的一个填充?
      return Padding(padding: EdgeInsets.zero,);
    }
  }
}