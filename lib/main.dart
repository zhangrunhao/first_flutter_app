import 'package:flutter/material.dart';
// import 'package:first_flutter_app/3/3.6.dart';
import 'package:first_flutter_app/3/3.7.dart';

void main(List<String> args) {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen()
    );
  }
}

class HomeScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter代码'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('跳转'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TextFieldAndFormRoute()
              )
            );
          },
        ),
      )
    );
  }
}