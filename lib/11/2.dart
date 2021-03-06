import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TestDioRoute(),
    );
  }
}

class TestDioRoute extends StatefulWidget {
  TestDioRouteState createState() => TestDioRouteState();
}
class TestDioRouteState extends State<TestDioRoute> {
  Dio _dio = Dio();

  @override
  build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FutureBuilder(
        future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Response response = snapshot.data;
            if (snapshot.hasError){
              return Text(snapshot.error.toString());
            }
            return ListView(
              children: response.data.map<Widget>((e) => 
                ListTile(title: Text(e["full_name"]))
              ).toList(),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class HttpTestRoute extends StatefulWidget{
  @override
  _HttpTestRouteState createState() => _HttpTestRouteState();
}

class _HttpTestRouteState extends State<HttpTestRoute> {
  bool _loading = false;
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("获取百度首页"),
              onPressed: _loading ? null : () async {
                setState(() {
                  _loading = true;
                  _text = "正在请求...";
                });
                try {
                  // 创建一个HttpClient
                  HttpClient httpClient = HttpClient();
                  // 打开http链接
                  HttpClientRequest request = await httpClient.getUrl(Uri.parse('https://baidu.com'));
                  // 使用iphone的UA
                  request.headers.add("user-agent", "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
                  // 等待链接服务器
                  HttpClientResponse response = await request.close();
                  // 读取响应内容
                  _text = await response.transform(utf8.decoder).join();
                  // 输出响应头
                  print(response.headers);
                  // HttpClientBasicCredentials("a", "123");
                  // 关闭client后, 通过该clinet发起的所有请求都会终止
                  httpClient.close();
                } catch (e) {
                  _text = "请求失败: $e";
                } finally {
                  setState(() {
                    _loading = false;
                  });
                }
              }
            ),
            Container(
              width: MediaQuery.of(context).size.width - 50.0,
              child: Text(_text.replaceAll(RegExp(r"\s"), '')),
            )
          ],
        ),
      ),
    );
  }
}
