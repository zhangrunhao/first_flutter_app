import 'package:flutter/material.dart';

class ConstrainedBoxRoute extends StatelessWidget {
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('5.2'),
        actions: <Widget>[
          UnconstrainedBox(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          )
        ],
      ),
      body: TestClassConstrainerdBox()
    );
  }
}

class TestSizedBox extends StatelessWidget {
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: redBox,
    );
  }
}


class TestClassConstrainerdBox extends StatelessWidget {
  Widget build(BuildContext context) {
    return ConstrainedBox(
        // 多个限制时, 对于min而言, 最大的生效
        // 多重限制时, 对于max而言, 最小的生效
        constraints: BoxConstraints(
          minWidth: 90,
          minHeight: 150,
          // maxHeight: 100
        ),
        child: UnconstrainedBox( // 上方留有空白, 证明还是 那150 的限制生效了, 只是会按照下方的100渲染
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 200,
              minHeight: 100
              // maxHeight: 200
            ),
            child: redBox
          ),
        )
      );
  }
}

Widget redBox = DecoratedBox(
  decoration: BoxDecoration(color: Colors.red),
);
