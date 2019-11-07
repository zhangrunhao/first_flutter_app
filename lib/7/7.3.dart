import 'dart:collection';

import 'package:flutter/material.dart';


// TODO: 始终不明白, <>表示了什么? 表示泛型.
// 一个通用的InheritedWidget, 保存任需要跨组件共享的状态
class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({
    @required this.data,
    Widget child
  }):super(child: child);
  
  // TODO: 泛型T是什么意思?
  final T data;
  
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

// TODO: 这里又定义了什么?
// 该方法用于在Dart中获取模板类型
Type _typeOf<T> () => T;

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierProvider({
    Key key,
    this.data,
    this.child
  });

  final Widget child;
  final T data;

  // 定义一个便捷方法, 便于在子树中的widget获取数据
  static T of<T>(BuildContext context) {
    // 也就是在获取数据的时候, 进行绑定
    final type = _typeOf<InheritedProvider<T>>();
    final provider = context.inheritFromWidgetOfExactType(type) as InheritedProvider<T>;
    return provider.data;
  }

  @override
  State<StatefulWidget> createState() {
    return _ChangeNotifierProviderState<T>();
  }
}

// 主要作用监听到共享状态(model)改变, 并重新构建Widget树.
// TODO: 为什么最后少了一个<T>, 就找不到data. of函数中的provider, 就是null??
class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>> {
  void update() {
    // TODO: 什么时候, 调用了update方法? 又是如何重新构建InheritedProvider
    // 如果数据发生变化 (model类调用了notifyListeners),   重新构建InheritedProvider
    setState(() {
    });
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    // 当Provider更新时候, 如果新旧数据不等, 则解绑旧数据监听, 同时添加新数据监听
    /**
     * 问: 这里的widget是什么? 是句柄吗?
     * 答: 
     * widget, 出现在特定的重写的函数中, 也就是生命周期函数中
     * 表示了使用这个State的Widget. 
    */
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    print(widget);
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移出model监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider(
      data: widget.data,
      /** 
       * TODO: 为什么是同一个引用就不会重新build了?setState引起的build范围到底有哪些?
       * widget.child 始终是同一个
       * 所以在执行build时, InheritedProvider使用的child引用没有变
       * 所以child, 不会重新执行build. 相当于对child进行了缓存.
       * 
       * 但如果ChangeNotifierProvider附近Widge build时, 改变了传入的child, 就没准了.
      */
      child: widget.child,
    );
  }
}

// 购物车类
class Item {
  Item({
    this.price,
    this.count
  });
  double price;
  int count;
}

// 定义一个保存购物车内商品数据的`CarModel`类
class CartModel extends ChangeNotifier {
  // 保存购物车中的商品列表
  final List<Item> _items = [];

  // 禁止改变购物车中的商品信息
  // TODO: 为什么通过修改 get items方法, 可以防止修改items信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // 购物车中商品的总价
  double get totalPrice => _items.fold(0, (value, item) => value + item.count * item.price);

  // 将item添加到购物车. 这是唯一一种能从外部改变购物车的方法.
  void add(Item item) {
    _items.add(item);
    // 通知监听者(订阅者更新状态), 重新构建InheritProvider, 更新状态.
    notifyListeners();
  }

}

class ProviderRoute extends StatefulWidget {
  @override
  _ProviderRouteState createState() {
    return _ProviderRouteState();
  }
}

class _ProviderRouteState extends State<ProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('7.3'),),
      body: Center(
        child: ChangeNotifierProvider(
          data: CartModel(),
          child: Builder(
            builder: (context) {
              return Column(
                children: <Widget>[
                  Builder(builder: (context) {
                    var car = ChangeNotifierProvider.of<CartModel>(context);
                    return Text('总价: ${car.totalPrice}');
                  },),
                  Builder(builder: (context) {
                    print('RadiseButton build');
                    return RaisedButton(
                      child: Text('添加商品'),
                      onPressed: () {
                        var car = ChangeNotifierProvider.of<CartModel>(context);
                        car.add(Item(price: 20, count: 1));
                      },
                    );
                  },),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/**
 * 总结运行过程: 
 * onPressed => car.add => notifyListeners()
 *  => ( _ChangeNotifierProviderState在initState阶段 设置了监听) => 
 * ChangeNotifierProvider 执行 build => InheritedProvider build 重构
 * => 依赖 InheritedProvider 的windget都会进行重构
 */