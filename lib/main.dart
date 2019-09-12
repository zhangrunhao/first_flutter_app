import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // 提供的顶级app框架
      title: 'Flutter Demo', // 名称
      home: Echo(text: '张润昊')
      // home: Scaffold()
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
  void initState() {
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
  void didUpdateWidget(Counter oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  @override
  void deactivate() { // 失效
    super.deactivate();
    print('deactivate');
  }

  @override
  void dispose() { // 丢掉, 处理, 安置
    super.dispose();
    print('dispose');
  }

  @override
  void reassemble() { // 重组
    super.reassemble();
    print('reassemble');
  }

  @override
  void didChangeDependencies() {
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

