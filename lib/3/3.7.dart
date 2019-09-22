import 'package:flutter/material.dart';

class TextFieldAndFormRoute extends StatelessWidget{
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('3.7'),),
      body: TextFieldAndForm(),
    );
  }
}

class TextFieldAndForm extends StatefulWidget {
 _TextFieldAndFormState createState () => _TextFieldAndFormState();
}

class _TextFieldAndFormState extends State{
  TextEditingController _unameController = TextEditingController(
    text: '1234567',
  );
  void initState () {
    super.initState();
    _unameController.selection = TextSelection(
      baseOffset: 2,
      extentOffset: _unameController.text.length
    );
    _unameController.addListener(() {
      print(_unameController.text);
    });
  }
  Widget build (BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          autofocus: true,
          controller: _unameController,
          onChanged: (value) {
          },
          decoration: InputDecoration(
            labelText: "用户名",
            hintText: "用户名或邮箱",
            prefixIcon: Icon(Icons.person)
          ),
        ),
        TextField(
          // autofocus: true,
          decoration: InputDecoration( // 控制外观
            labelText: "密码",
            hintText: "您的登录密码",
            prefixIcon: Icon(Icons.lock)
          ),
          obscureText: true,
        ),
        RaisedButton(
          child: Text('输出内容'),
          onPressed: () {
            print(_unameController.text);
          },
        )
      ],
    );
  }
}
