import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class ListViewRoute  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          ListTile(title: Text('商品列表'),),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(title: Text('$index'),);
              },
            ),
          )
          // SizedBox(
          //   // height: 400,
          //   // 可以用动态计算的方式进行解决, iphone11 还得多个20
          //   height: MediaQuery.of(context).size.height - 24 - 56 - 56 - 20,
          //   child: ListView.builder(
          //     itemBuilder: (context, index) {
          //       return ListTile(title: Text('$index'),);
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}

class ListViewRoute3 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('6.3'),),
      // body: InfiniteListView(),
      body: InfiniteListView(),
    );
  } 
}

class InfiniteListView extends StatefulWidget {
  @override
  _InfiniteListViewState createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const loadingTag = "##loading##"; // 表尾标记
  var _words = <String>[loadingTag];

  void _retriveData() {
    Future.delayed(Duration(milliseconds: 1000)).then((a) {
      // TODO: 如何把后面迭代器的代码抽出来
      _words.insertAll(_words.length - 1, generateWordPairs().take(20).map((e) => e.asCamelCase).toList());
      setState(() {
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _retriveData();
  }


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _words.length,
      itemBuilder: (context, index) {
        // 已经到了表尾
        if (_words[index] == loadingTag) {
          if (_words.length - 1 < 100) {
            _retriveData();
            return Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2,),
              ),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              child: Text('没有更多了', style: TextStyle(color: Colors.grey)),
            );
          }
        }
        // 没有到表尾
        return ListTile(title: Text(_words[index]),);
      },
      separatorBuilder: (context, index) => Divider(height: .0, color: Colors.red,),
    );
  }
}



class ListViewRoute2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget divider1 = Divider(color: Colors.green,);
    Widget divider2 = Divider(color: Colors.red,);

    return Scaffold(
      appBar: AppBar(title: Text('6.3'),),
      // 分离列表, 可以有一个分割组件构造器
      body: ListView.separated(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(title: Text('$index'),);
        },
        separatorBuilder: (BuildContext context, int index) {
          return index % 2 == 0 ? divider1 : divider2;
        },
      ),
      // ListView.builder适合构建无限列表
      // body: ListView.builder(
      //   itemCount: 100,
      //   itemExtent: 50,
      //   itemBuilder: (BuildContext context, int index) {
      //     return ListTile(title: Text("$index"),);
      //   },
      // )
    );
  }
}

class ListViewRoute1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('6.3'),),
      body: ListView(
        // shrinkWrap: true, // 是否根据子组件的长度设置ListView, 默认false, 如果为true, 会占用尽可能多的空间
        itemExtent: 30, // 每一项的宽度

        // 是否添加到`AutomaticKeepAlive`组件中.
        // 如果添加进去, 当滑出视口时候, 不会被GC, 会使用`KeepAliveNotification`保存状态
        // 如果要自己维护`KeepAlive`, 参数必须要false
        addAutomaticKeepAlives: false,

        // 是否添加到`RepaintBoundary`组件中.
        // 添加的话, 可以避免重绘, 提高性能. 但如果仅仅是颜色块或者文本, 不添加更高效
        // 如果要自己维护状态, 参数需要为false
        padding: EdgeInsets.all(20),
        children: <Widget>[
          const Text('I\'m dedicating every day to you'),
          const Text('Domestic life was never quite my style'),
          const Text('When you smile, you knock me out, I fall apart'),
          const Text('And I thought I was so smart'),
        ],
      )
    );
  }
}