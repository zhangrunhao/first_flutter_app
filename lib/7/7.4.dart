import 'package:flutter/material.dart';

class ThemeRoute extends StatefulWidget {
  @override
  _ThemeRouteState createState() {
    return _ThemeRouteState();
  }
  // @override
  // Widget build(BuildContext context) {
  //   //  将颜色字符串转化成Color对象
  //   // Color(0xffdc380d);
  //   // var c = "dc380d";
  //   // Color(int.parse(c, radix:16)|0xFF000000); //通过位运算符将Alpha设置为FF
  //   // Color(int.parse(c, radix:16)).withAlpha(255);   //通过方法将Alpha设置为FF
  //   return Scaffold(
  //     appBar: AppBar(),
  //     body: Column(
  //       children: <Widget>[
  //         NarBar(color: Colors.pink[50], title: '测试',),
  //         NarBar(title: '实测实施', color: Colors.black,)
  //       ],
  //     ),
  //   );
  // }
}

class _ThemeRouteState extends State<ThemeRoute> {
  Color _themeColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
  ThemeData themeData = Theme.of(context);
    // 这是单个路由页面的换皮肤, 修改 MaterialApp 可修改整个App的皮肤.
    return Theme(
      data: ThemeData(
        // primaryColor: _themeColor,
        primarySwatch: _themeColor,
        iconTheme: IconThemeData(color: _themeColor)
      ),
      child: Scaffold(
        appBar: AppBar(title: Text('颜色和主题'),),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 颜色跟随主题
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.favorite),
                Icon(Icons.airport_shuttle),
                Text('颜色跟随主题')
              ],
            ),
            // Icon自定义为黑色
            Theme(
              data: themeData.copyWith(
                iconTheme: themeData.iconTheme.copyWith(
                  color: Colors.black
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text('固定颜色黑色')
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.palette),
          onPressed: () {
            setState(() {
              _themeColor = _themeColor == Colors.teal ? Colors.blue : Colors.teal;
            });
          },
        ),
      ),
    );
  }
}

class NarBar extends StatelessWidget {
  NarBar({
    this.title,
    this.color
  });
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 52,
        minWidth: double.infinity
      ),
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 3),
            blurRadius: 3
          )
        ]
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          // computeLuminance 返回一个0-1的数值 数值越大颜色越浅
          color: color.computeLuminance() < 0.5 ? Colors.white : Colors.black
        ), 
      ),
      alignment: Alignment.center,
    );
  }
}
