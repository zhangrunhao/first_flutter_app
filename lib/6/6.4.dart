import 'package:flutter/material.dart';

class GridViewRoute extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('6.4'),),
      body: InfiniteGridView(),
    );
  }
}

class InfiniteGridView extends StatefulWidget {
  @override
  _InfiniteGridViewState createState() => _InfiniteGridViewState();
}

class _InfiniteGridViewState extends State<InfiniteGridView> {

  List<IconData> _icons = []; // 保存Icon数据

  @override
  void initState() {
    super.initState();
    _retrieveIcons();
  }
  void _retrieveIcons () {
    Future.delayed(Duration(milliseconds: 200)).then((e) => {
      setState(() { 
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access, Icons.cake,
          Icons.free_breakfast
        ]);
      })
    });
  }
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1
      ),
      itemCount: _icons.length,
      itemBuilder: (context, index) {
        if (index == _icons.length - 1) {
          _retrieveIcons();
        }
        return Icon(_icons[index]);
      },
    );
  }
}

class TestSliverGridDelegateWithMaxCrossAxisExtent extends StatelessWidget {
  Widget build(BuildContext context) {
    return GridView(
      // 横轴子元素为固定最大宽度
      // == GridView.extent
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 120,
        childAspectRatio: 2
      ),
      children: <Widget>[
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast)
      ],
    );
  }
}

class TestGridCount extends StatelessWidget {
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: <Widget>[
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast)
      ],
    );
  }
}

class TestSliverGridDelegateWithFixedCrossAxisCount extends StatelessWidget {
  Widget build(BuildContext context) {
    return GridView(
      // GridView.count 就是SliverGridDelegateWithFixedCrossAxisCount方式构成
      // 很轴为固定数量子元素的layout算法
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 横轴子元素的数量
        // crossAxisSpacing: 1, // 横轴方向上子元素间距
        // mainAxisSpacing: 100, // 主轴方向的间距
        childAspectRatio: 1 // 子元素在横轴和纵轴长度的比例
      ),
      children: <Widget>[
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast)
      ],
    );
  }
}