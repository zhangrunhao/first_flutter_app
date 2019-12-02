import 'package:flutter/material.dart';
// import 'package:first_flutter_app/3/3.1.dart';
// import 'package:first_flutter_app/3/3.6.dart';
// import 'package:first_flutter_app/3/3.7.dart';
// import 'package:first_flutter_app/3/3.8.dart';
// import 'package:first_flutter_app/4/4.2.dart';
// import 'package:first_flutter_app/4/4.3.dart';
// import 'package:first_flutter_app/4/4.4.dart';
// import 'package:first_flutter_app/4/4.5.dart';
// import 'package:first_flutter_app/4/4.6.dart';
// import 'package:first_flutter_app/5/5.1.dart';
// import 'package:first_flutter_app/5/5.2.dart';
// import 'package:first_flutter_app/5/5.3.dart';
// import 'package:first_flutter_app/5/5.4.dart';
// import 'package:first_flutter_app/5/5.5.dart';
// import 'package:first_flutter_app/5/5.6.dart';
// import 'package:first_flutter_app/5/5.7.dart';
// import 'package:first_flutter_app/6/6.2.dart';
// import 'package:first_flutter_app/6/6.3.dart';
// import 'package:first_flutter_app/6/6.4.dart';
// import 'package:first_flutter_app/6/6.5.dart';
// import 'package:first_flutter_app/6/6.6.dart';
// import 'package:first_flutter_app/7/7.1.dart';
// import 'package:first_flutter_app/7/7.2.dart';
// import 'package:first_flutter_app/7/7.3.dart';
// import 'package:first_flutter_app/7/7.4.dart';
// import 'package:first_flutter_app/7/7.5.dart';
// import 'package:first_flutter_app/7/7.6.1.dart';
// import 'package:first_flutter_app/7/7.6.2.dart';
// import 'package:first_flutter_app/8/8.1.dart';
// import 'package:first_flutter_app/8/8.2.dart';
// import 'package:first_flutter_app/8/8.4.dart';
// import 'package:first_flutter_app/9/9.2.dart';
// import 'package:first_flutter_app/9/9.3.dart';
// import 'package:first_flutter_app/9/9.4.dart';
// import 'package:first_flutter_app/9/9.5.dart';
// import 'package:first_flutter_app/9/9.6.dart';
// import 'package:first_flutter_app/9/9.7.dart';
// import 'package:first_flutter_app/9/9.7.dart';
import 'package:first_flutter_app/10/2.dart';


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
                builder: (context) => CustomCompontentsComposeRoute()
              )
            );
          },
        ),
      )
    );
  }
}
