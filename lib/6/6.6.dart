import 'package:flutter/material.dart';


class ScrollerNotificationTestRoute extends StatefulWidget {
  @override
  _ScrollerNotificationTestRouteState createState() {
    return _ScrollerNotificationTestRouteState();
  }
}

class _ScrollerNotificationTestRouteState extends State<ScrollerNotificationTestRoute>  {

  String _progress = '0%'; // 保存进度百分比

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('6.6'),),
      body: Scrollbar(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            /**
             * pixels: 当前位置
             * maxScrollExent: 最大的滚动位置
             * extentBefore: 滑出超过ViewPort顶部的位置
             * extentInside: ViewPort内部长度
             * extentAfter: 列表未滑入ViewPort部分
             * atEdge: 是否滑到了组件的边界
             */
            double progress = notification.metrics.pixels / notification.metrics.maxScrollExtent;
            setState(() {
              _progress = "${(progress * 100).toInt()}%";
            });
            print("BottomEdge: ${notification.metrics.extentAfter == 0}");
            // return true;
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ListView.builder(
                itemCount: 100,
                itemExtent: 50,
                itemBuilder: (context, index) {
                  return ListTile(title: Text('$index'),);
                },
              ),
              CircleAvatar(
                radius: 30,
                child: Text(_progress),
                backgroundColor: Colors.black54,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ScrollerControllerRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScrollerControllerRouteState();
  }
}

class _ScrollerControllerRouteState extends State<ScrollerControllerRoute> {
  ScrollController _controller = ScrollController();
  bool showToTopBtn = false; // 是否显示返回顶部按钮

  @override
  void initState() {
    super.initState();
    print('init');
    _controller.addListener(() {
      print(_controller.offset);
      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && showToTopBtn == false) {
        print('true');
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // 避免内存泄露
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('滚动控制'),),
      body: Scrollbar(
        // TODO: PageStorage如何使用存储滚动位置
        child: ListView.builder(
          controller: _controller,
          itemCount: 100,
          itemExtent: 50, // 列表高度固定时, 显示指定高度是一个好习惯 (性能消耗小)
          itemBuilder: (context, index) {
            return ListTile(title: Text('$index'),);
          },
        ),
      ),
      floatingActionButton: !showToTopBtn ? null : FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () {
          _controller.animateTo(
            .0, 
            duration: Duration(seconds: 1), 
            curve: Curves.ease,
          );
        },
      ),
    );
  }
}
