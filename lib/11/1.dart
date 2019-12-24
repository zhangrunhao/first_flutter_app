// import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';

/*
 * 临时目录: getTemporaryDirectory
 * 
 */
class FileOperationRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('11.1'),),
      body: Text('11.1'),
    );
  }
}

// class Test1 extends StatefulWidget{
//   Test1({
//     Key key
//   }) : super(key: key);
//   @override
//   _Test1State createState() => _Test1State();
// }

// class _Test1State extends State<Test1> {
//   int _counter;

//   Future<File> _getLocalFile() async {
//     // 获取应用目录
//     String dir = (await getApplicationDocumentsDirectory()).path;
//     return File([null], '$dir/counter.txt');
//   }
//   Future<int> _readCounter() async {
//     // try {
//     //   File file = await _getLocalFile();
//     // }
//   }

//   @override
//   void initState() {
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return null;
//   }
// }
