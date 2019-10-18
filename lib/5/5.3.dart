import 'package:flutter/material.dart';

class DecorateBoxRoute extends StatelessWidget {
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('5.3'),),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.red, Colors.orange[700]]), // 渐变
          borderRadius: BorderRadius.circular(3), // 圆角
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(2, 2),
              blurRadius: 4
            )
          ]
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 18),
          child: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}