import 'package:flutter/material.dart';

class PaddingRoute extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('5.1'),),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          // 显示左对齐, 避免干扰, 等会进行干扰测试
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text('Hello world'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Text('I am Jack'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 200, 300, 20),
              child: Text('Your friend'),
            )
          ],
        ),
      ),
    );
  }
}