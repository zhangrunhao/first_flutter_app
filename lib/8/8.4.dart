import 'package:flutter/material.dart';

class NotifinationTestRoute extends StatelessWidget{
  // 通知冒泡可以终止, 但用户触摸事件不行
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("8.4"),),
      body: Test2(),
    );
  }
}

class MyNotification extends Notification{
  MyNotification(this.msg);
  final String msg;
}

class Test2 extends StatefulWidget{
  @override
  _Test2State createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  String _msg = "";
  @override
  Widget build(BuildContext context) {
    return NotificationListener<MyNotification>(
      onNotification: (notification) { // 接收到分发的通知
        setState(() {
          _msg += notification.msg + "  ";
        });
        return true;
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /**
             * 这里的context是 根context
             * NotificationListener 监听的是子树.
             * 所以通过Builder获取按钮的context
             */
            // RaisedButton(
            //   onPressed: () => MyNotification("Hi").dispatch(context),
            //   child: Text("Send Notifition"),
            // ),
            Builder(
              builder: (BuildContext context) {
                return RaisedButton(
                  /**
                   * dispatch 用来分发通知的过程:
                   * dispatch => visitAncestor => 
                   * 判断当前widget是否是NotificationListener
                   * 如果是的话, 继续调用_dispatch. 
                   * 如果不是, 然后true, 继续上上找.
                   * 
                   * _dispatch => 
                   * 
                   * 如果监控器不为空, 执行onNotification
                   * 并返回 result == true.
                   * 
                   * 
                   * 额外注意:
                   * 1. Context上也提供了遍历Element树的方法
                   * 2. 可以通过Element.widget或者element结对对应的widget
                   */
                  onPressed: () => MyNotification("Hi").dispatch(context),
                  child: Text("Send Notifition"),
                );
              },
            ),
            Text(_msg)
          ],
        ),
      ),
    );
  }
}


class Test1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      // 返回true, 不再继续冒泡
      onNotification: (notification) {
        switch (notification.runtimeType) {
          case ScrollStartNotification: print("开始滚动"); break;
          case ScrollUpdateNotification: print("正在滚动"); break;
          case ScrollEndNotification: print("停止滚动"); break;
          case OverscrollIndicatorNotification: print("滚动到边界"); break;
        }
      },
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(title: Text("$index"),);
        },
      ),
    );
  }
}