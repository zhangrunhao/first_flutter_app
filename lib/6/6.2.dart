import 'package:flutter/material.dart';

class SingleChildScrollViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return Scaffold(
      appBar: AppBar(title: Text('6.2'),),
      body: SingleChildScrollView(
        //  scrollDirection: Axis.horizontal, 滚动方向, 默认数值
        // reverse: false, // 是否按照阅读方向相反滑动
        // primary: true, // 是否使用默认的PrimaryScrollControler
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: str.split('')
              .map((c) => Text(c, textScaleFactor: 2,))
              .toList(),
          ),
        ),
      ),
    );
  }
}
