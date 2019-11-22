import 'package:flutter/material.dart';

// class HeroAnimationRoute extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("9.4"),),
//       body: Text("9.4"),
//     );
//   }
// }

class HeroAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.bottomCenter,
        child: InkWell(
          /**
           * Hero 组件只需要将共享的组件widget包装起来, 并提供同一个tag即可.
           * Flutter Framework内部通过tag确定新旧路由页对应的widget关系.
           * 相同tag, 只需要确定共享元素的位置和大小, 进行过度动画
           */
          child: Hero(
            tag: "avatar",
            child: ClipOval(child: Image.asset("images/aliya.jpg", width: 50,),),
          ),
          onTap: () {
            Navigator.push(context, PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondryAnimation) {
                return FadeTransition(
                  opacity: animation,
                  child: Scaffold(
                    appBar: AppBar(title: Text("new Page"),),
                    body: HeroAnimationRouteB(),
                  ),
                );
              }
            ));
          },
        ),
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: "avatar",
        child: Image.asset("images/aliya.jpg"),
      ),
    );
  }
}