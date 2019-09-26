import 'package:flutter/material.dart';

class TextProgressIndicatorRoute extends StatelessWidget {
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('3.8'),),
      body: TextProgressIndicate(),
    );
  }
}

class TextProgressIndicate extends StatefulWidget {
  @override
  _TextProgressIndicateColorState createState () => _TextProgressIndicateColorState();
}


// TODO: width 表示什么, 后面那个mixin又是什么
class _TextProgressIndicateColorState extends State<TextProgressIndicate> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState () {
    // TODO: 不能理解AnimationController的距离逻辑
    // 动画执行三秒
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 3
      )
    );
    _animationController.forward();
    _animationController.addListener(() => setState(() => {}));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: ColorTween(
                begin: Colors.grey,
                end: Colors.blue
              ).animate(_animationController),
              value: _animationController.value,
            ),
          )
        ],
      ),
    );
  }
}

class _TextProgressIndicateState extends State<TextProgressIndicate> {
  Widget build (BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: 50,
          height: 20,
          child: LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
        ),
        LinearProgressIndicator(
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation(Colors.blue),
          value: 0.5,
        ),
        SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.blue),
            strokeWidth: 10,
            // value: .5,
          ),
        )
      ],
    );
  }
}