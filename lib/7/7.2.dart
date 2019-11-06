import 'package:flutter/material.dart';

/*
 * didChangeDependencies 会在'依赖'发生变化时执行
 * 依赖: 是否使用了父Widget中的inheritedWidget的数据
 */
class InheritedWidgetTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InheritedWidgetTestRouteState();
  }
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {

  int count = 0;

  @override
  Widget build(BuildContext context) {
    print(count);
    return Scaffold(
      appBar: AppBar(title: Text('7.2'),),
      body: Center(
        child: ShareDataWidget( // 使用ShareDataWidget
          data: count,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: _TestWidget(),
              ),
              RaisedButton(
                child: Text('Increment'),
                // 每点击一次, 将count自增, 就会重新build, 所以ShareDataWidget也会改变
                onPressed: () => setState(() => ++count),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ShareDataWidget extends InheritedWidget {
  const ShareDataWidget({
    @required this.data,
    Widget child
  }):super(child: child);

  final int data; // 需要在子树中共享的数据, 保存点击次数

  // 定义一个便捷方法, 方便子树中的widget获取共享数据
  static ShareDataWidget of(BuildContext context) {
    //  inheritFromWidgetOfExactType 注入了依赖关系
    // ancestorInheritedElementForWidgetOfExactType 不会注入依赖

    // return context.inheritFromWidgetOfExactType(ShareDataWidget);
    return context.ancestorInheritedElementForWidgetOfExactType(ShareDataWidget).widget;
  }

  // 该回调决定, 当data发送变化时候, 是否通知子树中依赖data的widget
  @override
  bool updateShouldNotify(ShareDataWidget old) {
    // 如果返回true, 则子树中依赖本widget的子widget中 state.didChangeDependencies 会被调用
    return old.data != data;
  }
}

class _TestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestWidgetState();
  }
}

class _TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    /**
     * 没有依赖依旧执行build的原因:
     * _InheritedWidgetTestRouteState 执行了 setState
     * setState 会重构整个页面
     * 因_TestWidget没有缓存, 所以也会进行重构
     */
    print('build');
    // 使用ShareDataWidget中共享的数据
    return Text(ShareDataWidget.of(context).data.toString());
  }

  @override
  // 如果依赖改变后, 需要进行一些昂贵的操作, 例如请求网络, 可以在这里进行
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 父或者祖先widget中 InheritedWidget 改变, (updateShouldNotify返回true)
    // 如果build没有使用 InheritedWidget. 则不会调用
    print('dependencies change');
  }
}