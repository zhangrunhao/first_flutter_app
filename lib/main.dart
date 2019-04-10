// 导入了一套material的UI组件库, flutte默认使用的
import 'package:flutter/material.dart';

// runApp 顶级的入口函数, 单行函数, 直接执行了
void main() => runApp(MyApp());

// MyApp 函数的执行返回了一个全局的widget
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // 提供的顶级app框架
      title: 'Flutter Demo', // 名称
      theme: ThemeData( // 主题
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'), // 首页
    );
  }
}

// Stateful widget: 有状态的类, 这些状态在widget的声明周期中可变. Stateless widget: 状态不可变的类 
// Stateful widget: 由两部分构成`StatefulWidget`和`State`构成. 类本身不变, 但是State是变化的.


// 应用首页
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> { // 一个状态类
  int _counter = 0; // 状态, 保存点击的次数
  // 当第一次MyHomePage创建的时候, 这个State类就创建了.
  // 初始化完成后, Flutter通过调用Widget的build来构建展示树

  void _incrementCounter() { // 点击后调用此方法
    setState(() { // setState方法, 用来通知Flutter更新状态, 如果直接执行, 没效果.
      // 可以在此处更新任何需要更新的地方, 无需单独更新widget状态
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) { // 构建UI界面, build放到这, 1.访问状态比较方便. 2.继承的时候, 不用调父类的build
    // 每一次setState都会执行, build方法已经被优化, 即可以重建任何需要更新的东西, 而不需要单独更新widgets
    return Scaffold( // 页面脚手架, 可以很复杂, 这里包括了appBar, body, 
      appBar: AppBar(
        // App.build的时候, 创建了MyHomePage对象, 我们拿到创建时候的值, 来设置我们的导航栏
        title: Text(widget.title),
      ),
      body: Center( // Center是一个布局widget, 可以让一个简单的元素, 定位在父元素的中间
        child: Column( // Colunm也是布局, 可以让父元素垂直布局.
          // 默认调整自己的大小, 适应水平方向的
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
