// import 'package:flutter/widgets.dart'; // 如果引入风格组件库, 则不需要引入基础组件
import 'package:flutter/material.dart'; // Material组件库
import 'package:flutter/cupertino.dart'; // 另一套风格的组件库
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // 提供的顶级app框架
      title: 'Flutter Demo', // 名称
      // home: ConterRoute(),
      // home: Echo(text: '张润昊'),
      // home: ShowSnackBar(),
      home: CupertinoTestRoute(),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({
    Key key,
    this.initValue: 0,
  });

  final int initValue;

  _CounterState createState() => new _CounterState();
}

class _CounterState extends State<Counter> {
  int _couter;

  @override
  void initState() { // 第一次插入到widget树中
    super.initState();
    // 初始化状态
    _couter=widget.initValue;
    print('initState');
  }

  @override
  Widget build(BuildContext content) {
    print('build');
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text('$_couter'),
          // TODO: 不明白,在这个语法, 在表示什么.
          onPressed: () => setState(
            () => ++_couter
          ),
        ),
      ),
    );
  }
  @override
  void didUpdateWidget(Counter oldWidget) {  // widget发生重建时
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  @override
  void deactivate() { // State对象从树中移出, 但可能是插入到其他地方, 也可能是直接移出了
    super.deactivate();
    print('deactivate');
  }

  @override
  void dispose() { // 如果是State对象直接移出了, 就会调用这个回调
    super.dispose();
    print('dispose');
  }

  @override
  void reassemble() { // 重组, 并未执行
    super.reassemble();
    print('reassemble');
  }

  @override
  void didChangeDependencies() { // State对象依赖发生变化时.
    super.didChangeDependencies();
    print('didChangeDependencies');
  }
}

class Echo extends StatelessWidget {
  const Echo({ // 这里是构造函数
    Key key,
    @required this.text,
    this.backgroundColor: Colors.grey,
  }):super(key: key); // super相当于父类, 这就是父类的初始化

  final String text; // 必须在构造函数中进行初始化
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: new Column(
          children: <Widget>[
            new Text(text),
            new FlatButton(
              child: Text('跳转新页面'),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) {
                      // return ContextRoute();
                      return  ConterRoute();
                      // return Text('xxx');
                    },
                  )
                );
              },
            ),
          ],
        )
      ),
    );
  }
}

class ConterRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试生命周期'),
      ),
      body: Counter(),
    );
  }
}

class ContextRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( // 这是页面的路由的一个脚手架
      appBar: AppBar( // bar
        title: Text('Context测试'),
      ),
      body: Container( // 内容
        child: Builder(
          builder: (context) { // 这是往Builder的类中, new的时候, 传入了一个函数. 
            // 在Widget树中向上查找最近的父级`Scaffold`
            Scaffold scaffold = context.ancestorWidgetOfExactType(Scaffold);
            // TODO: 不明白 scaffold.child as AppBar什么语法含义
            return (scaffold.appBar as AppBar).title;
          }
        ),
      ),
    );
  }
}

class ShowSnackBar extends StatelessWidget {
  const ShowSnackBar({
    Key key
  }):super(key: key);

  static GlobalKey<ScaffoldState> _globalKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('子树中获取State对象'),
      ),
      body: Center(
        child: Builder(
          builder: (context) {
            return RaisedButton(
              // 第一种获取State对象的方法
              onPressed: () {
                // ScaffoldState _state = context.ancestorStateOfType(TypeMatcher<ScaffoldState>());
                // 如果state对象希望暴露, 默认提供一个`of`方法进行获取
                // ScaffoldState _state = Scaffold.of(context);
                // 通过GlobalKey获取State对象
                ScaffoldState _state = _globalKey.currentState;
                _state.showSnackBar(
                  SnackBar(
                    content: Text('我是SnackBar'),
                  ),
                );
              },
              child: Text('显示SnackBar'),
            );
          },
        ),
      ),
    );
  }
}

class CupertinoTestRoute extends StatelessWidget {
  const CupertinoTestRoute({
    Key key,
  }):super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cupertino demo'),
      ),
      child: Center(
        child: CupertinoButton(
          color: CupertinoColors.activeBlue,
          child: Text('Press'),
          onPressed: () {},
        ),
      ),
    );
  }
}
