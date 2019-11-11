import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DialogTest(),
    ); 
  } 
}

class DialogTest extends StatefulWidget {
  @override
  _DialogRouteState createState() {
    return _DialogRouteState();
  }
}

class _DialogRouteState extends State<DialogTest> {
  bool withThree = true;
  @override
  Widget build(BuildContext context) {
    return  Column(
        children: <Widget>[
          RaisedButton(
            child: Text("_showDatePicker2"),
            onPressed: () => _showDatePicker2(),
          ),
          RaisedButton(
            child: Text("_showDatePicker1"),
            onPressed: () => _showDatePicker1(),
          ),
          RaisedButton(
            child: Text("showLoadingDialog"),
            onPressed: () {
              showLoadingDialog();
            },
          ),
          RaisedButton(
            child: Text("_showModalBottomSheet"),
            onPressed: () async {
              PersistentBottomSheetController controller =  _showModalBottomSheet();
              print(controller);
            },
          ),
          RaisedButton(
            child: Text('showDeleteConfirmDialog'),
            onPressed: () async {
              var res = await showDeleteConfirmDialog();
              print(res);
            },
          )
        ],
      );
  }

  Future<DateTime> _showDatePicker2() {
    var date = DateTime.now();
    return showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            minimumDate: date,
            maximumDate: date.add(Duration(days: 30)),
            maximumYear: date.year + 1,
            onDateTimeChanged: (DateTime value) {
              print(value);
            },
          ),
        );
      }
    );
  }

  Future<DateTime> _showDatePicker1() {
    var date = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: date.add(Duration(days: 30)),
    );
  }
  showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        // 因为在showDialog中已经对 对话框进行了限制, 所以要先解除限制
        return UnconstrainedBox(
          constrainedAxis: Axis.vertical,
          child: SizedBox(
            width: 280,
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(top: 26),
                    child: Text("正在加载"),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  // Future<int> _showModalBottomSheet() {
  // 这种方式, 必须让上层组件中包含一个Scaffold
  PersistentBottomSheetController<int> _showModalBottomSheet() {
    // return showModalBottomSheet(
    return showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: 30,
          itemExtent: 30,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("$index"),
              onTap: () => Navigator.of(context).pop(index),
            );
          },
        );
      }
    );
  }

  // 猜测在函数后面的泛型, 表示, 返回的类型.
  // 如果使用一个函数的时候, 表示第一个传入的参数的类型
  Future<bool> showDeleteConfirmDialog() {
    bool withThree = false;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('提示'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('确定删除当前文件吗?'),
              Row(
                children: <Widget>[
                  Text("同时删除子目录"),
                  Builder(
                    // 通过Builder缩小context范围, 进行性能优化
                    builder: (BuildContext context) {
                      return Checkbox(
                        value: withThree,
                        onChanged: (bool value) {
                          (context as Element).markNeedsBuild();
                          withThree = !withThree;
                        },
                      );
                    },
                  ),
                  //  Checkbox(
                  //    value: withThree,
                  //    onChanged: (bool value) {
                  //      // 直接进将对话框的UI标记为dirty
                  //      (context as Element).markNeedsBuild();
                  //       withThree = !withThree;
                  //    },
                  //  ),
                  // Checkbox(
                  //   value: withThree,
                  //   onChanged: (bool value) {
                  /**
                   * 问: 如何在函数中获得context同时, 获得setSate方法.
                   * 答: StatefulBuilder方法即可
                  */
                  //     setState(() {
                  //       // 因为这里的widget不是在build中构建, 而是showDialog单独构建, 故不能起作用
                  //       // 或者: 如果这里是路由的方式, 这个方法便是父路由调用子路由, 所以不能成功
                  //       withThree = !withThree;
                  //     });
                  //   },
                  // )
                  // 因为DialogChekbox自己维护状态, 不再是showDialog产生, 而是自己维护状态.
                  // 故可以进行UI的更新
                  // DialogCheckbox(
                  //   value: withThree,
                  //   onChanged: (bool v) {
                  //     withThree = !withThree;
                  //   },
                  // ),
                  // StatefulBuilder(
                  //   builder: (context, _setState) {
                  //     return Checkbox(
                  //       value: withThree,
                  //       onChanged: (bool value) {
                  //         // 这里的_setState调用了父级StatefulBuilder的setState
                  //         // 所以, 可以重新build
                  //         _setState(() {
                  //           withThree = !withThree;
                  //         });
                  //       },
                  //     );
                  //   },
                  // ),
                ],
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              // 因为对话框的原理是通过路由实现的
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () => Navigator.of(context).pop(withThree),
            )
          ],
        );
      }
    );
  }
}

class DialogCheckbox extends StatefulWidget {
  DialogCheckbox({
    Key key,
    this.value,
    @required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  State<StatefulWidget> createState() {
    return _DialogCheckboxState();
  }
}

class _DialogCheckboxState extends State<DialogCheckbox> {
  bool value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (v) {
        // 将状态通过事件的方式导出
        widget.onChanged(v);
        setState(() {
          // 更新自身的选中状态
          value = v;
        });
      },
    );
  }
}

class StatefulBuilder extends StatefulWidget{
  StatefulBuilder({
    Key key,
    @required this.builder,
  }) : assert(builder != null), 
       super(key: key);

  final StatefulWidgetBuilder builder;

  @override
  _StatefulBuilderState createState() {
    return _StatefulBuilderState();
  }
}

class _StatefulBuilderState extends State<StatefulBuilder> {
  @override
  Widget build(BuildContext context) => widget.builder(context, setState);
}
