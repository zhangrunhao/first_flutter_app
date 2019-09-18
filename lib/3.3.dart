
import 'package:flutter/material.dart';

void main () {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build (BuildContext context) {
    return MaterialApp(
      title: '3.3',
      home: Scaffold(
        appBar: AppBar(title: Text('3.3'),),
        body: TestTextClass(),
      ),
    );
  }
}

class TestTextClass extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Container(
      width: 400,
      child: Column(
        children: <Widget>[
          Container(
            width: 300,
            child: Text(
              'Hello World',
              textAlign: TextAlign.right,
            ),
          ),
          Text(
            'Hello i am jack, who are you?' * 4,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Hello World',
            textScaleFactor: 1.5,
          )
        ],
      )
    );
  }
}
