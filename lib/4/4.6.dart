import 'package:flutter/material.dart';

class AlignRoute extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('4.6'),),
      body: TestAlign(),
    );
  }
}

class TestAlign extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      // height: 120.0,
      // width: 120.0,
      color: Colors.blue[50],
      child: Align(
        widthFactor: 2,
        heightFactor: 2,
        // alignment: Alignment.topRight,
        // alignment: Alignment(2, 0),
        alignment: FractionalOffset(0.2, 0.6),
        child: FlutterLogo(size: 60,),
      ),
    );
  }
}