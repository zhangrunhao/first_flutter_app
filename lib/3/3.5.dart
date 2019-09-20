import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: TestIconFont(),
      ),
    );
  }
}

class TestIconFont extends StatefulWidget {
  @override
  _TestIconFontState createState () => _TestIconFontState();
}
class _TestIconFontState extends State{

  @override
  Widget build (BuildContext context) {
    String icons = '';
    icons += "\uE914";
    icons += "\uE000";
    icons += "\uE90D";
    return Column(
      children: <Widget>[
        Icon(
          MyIcon.hotdog
        ),
        Text(
          icons,
          style: TextStyle(
            fontFamily: "MaterialIcons",
            fontSize: 42,
            color: Colors.green
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              MyIcon.hotdog,
              color: Colors.green,
            )
          ],
        )
      ],
    );
  }
}

class MyIcon {
  static const IconData hotdog = const IconData(
    // TODO: 最终没有调试出正常的阿里图标, 不清楚原因
    // 0xe603,
    0603,
    fontFamily: 'myIcon',
    matchTextDirection: true
  );
}

class TestImage extends StatelessWidget {
  Widget build (BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage("images/download.jpg"),
          width: 100.0,
        ),
        Image.network(
          "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
          width: 200,
          height: 100,
          fit: BoxFit.contain, // 图片的适配规则
          color: Colors.blue, // 主题颜色
          colorBlendMode: BlendMode.difference, // 颜色混合模式
          repeat: ImageRepeat.repeatX,
        )
      ]
    );
  }
}