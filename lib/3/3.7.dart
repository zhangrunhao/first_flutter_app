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
 _TextFieldCustomStyleState createState () => _TextFieldCustomStyleState();
}

class _TextFieldCustomStyleState extends State {
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        hintColor: Colors.grey[200],
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.grey), // 定义label字体样式
          hintStyle: TextStyle(color: Colors.red, fontSize: 12) // 定义提示文本样式
        )
      ),
      child: Column(
        children: <Widget>[
          // 优先通过decoration进行定义
          // 其次可以通过Them进行修改, 或者通过嵌套Widget
          Container(
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "电子邮件地址",
                prefixIcon: Icon(Icons.email),
                border: InputBorder.none
              ),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[200], width: 1.0)
              )
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "用户名",
              hintText: "用户名或邮箱",
              prefixIcon: Icon(Icons.person)
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "密码",
              hintText: "您的登录密码",
              prefixIcon: Icon(Icons.lock)
            ),
            obscureText: true,
          )
        ],
      ),
    );
  }
}

class _TextFieldAndFormState extends State{
  TextEditingController _unameController = TextEditingController(
    text: '1234567',
  );

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  FocusScopeNode focusScopeNode;

  void initState () {
    super.initState();
    _unameController.selection = TextSelection(
      baseOffset: 2,
      extentOffset: _unameController.text.length
    );
    _unameController.addListener(() {
      print(_unameController.text);
    });
    print('init');
    focusNode1.addListener(() {
      print(focusNode1.hasFocus);
    });
  }
  Widget build (BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          focusNode: focusNode1,
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
          focusNode: focusNode2,
          // autofocus: true,
          decoration: InputDecoration( // 控制外观
            labelText: "密码",
            hintText: "您的登录密码",
            prefixIcon: Icon(Icons.lock)
          ),
          obscureText: true,
        ),
        RaisedButton(
          child: Text('切换焦点'),
          onPressed: () {
            /**
             * 1. FocusScope.of(context)获取Widget树中默认的FocusScopeNode
             * 2. 把焦点移动到第二个文本输入框中
             */
            // 第一种写法
            // FocusScope.of(context).requestFocus(focusNode2);
            if (null == focusScopeNode) {
              focusScopeNode = FocusScope.of(context);
            }
            focusScopeNode.requestFocus(focusNode2);
          },
        ),
        RaisedButton(
          child: Text('隐藏键盘'),
          onPressed: () {
            focusNode1.unfocus();
            focusNode2.unfocus();
          },
        )
      ],
    );
  }
}
