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
              child: Text('调整新页面'),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ContextRoute();
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
            return (scaffold.appBar as AppBar).title;
          }
        ),
      ),
    );
  }
}

