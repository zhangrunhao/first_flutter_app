import 'package:flutter/material.dart';

class CustomScrollViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Demo'),
              background: Image.asset('images/aliya.jpg', fit: BoxFit.cover,),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 4
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.cyan[100 * (index % 9)],
                  child: Text('grid item $index'),
                );
              }, childCount: 20),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 50,
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text('list item $index'),
              );
            }, childCount: 50),
          )
        ],
      ),
    );
  }
}