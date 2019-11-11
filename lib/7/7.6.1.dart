import 'package:flutter/material.dart';
class AlertDialogRoute extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('7.6'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('对话框1'),
            onPressed: () async {
              // 这里的delete , 对应下面pop出来的值
              bool delete = await showDeleteConfirmDialog1(context);
              print(delete);
            },
          ),
          RaisedButton(
            child: Text("对话框2"),
            onPressed: () => changeLanguage(context),
          ),
          RaisedButton(
            child: Text("对话框3"),
            onPressed: () => showListDialog(context),
          ),
          RaisedButton(
            child: Text('showCustomDialog'),
            onPressed: () {
              showCustomDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("提示"),
                    content: Text("您确定要删除当前文件吗?"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("取消"),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      FlatButton(
                        child: Text("确定"),
                        onPressed: () => Navigator.of(context).pop(true),
                      )
                    ],
                  );
                }
              );
            },
          )
        ],
      ),
    );
  }
}

Future<T> showCustomDialog<T>({
  @required BuildContext context,
  bool barrierDismissble = true,
  WidgetBuilder builder,
}) {
  final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
  return showGeneralDialog(
    context: context,
    barrierDismissible: barrierDismissble,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black87,
    transitionDuration: Duration(milliseconds: 300),
    transitionBuilder: _builderMaterialDialogTransitions,
    // TODO: 这里的函数完全没有读懂
    pageBuilder: (
      BuildContext buildContext,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      final Widget pageChild = Builder(builder: builder,); 
      return SafeArea(
        child: Builder(
          builder: (BuildContext context) {
            return theme != null ? Theme(data: theme, child: pageChild,) : pageChild;
          },
        ),
      );
    },
  );
}

// TODO: 不能理解动画的生成方式.
Widget _builderMaterialDialogTransitions(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return ScaleTransition(
    child: child,
    scale: CurvedAnimation(
      parent: animation,
      curve: Curves.ease,
    ),
  );
}

Future<void> showListDialog(BuildContext context) async {
  int index = await showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      Widget child = Column(
        children: <Widget>[
          ListTile(title: Text("请选择"),),
          Expanded(
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("$index"),
                  onTap: () => Navigator.of(context).pop(index),
                );
              },
            ),
          )
        ],
      );
      // ListView不能确定高度, 所以不能使用AlertDialog
      // return Dialog(child: child,);
      return UnconstrainedBox(
        constrainedAxis: Axis.vertical,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 280),
          child: Material(
            child: child,
            type: MaterialType.card
          ),
        ),
      );
    }
  );
  print(index);
}

Future<void> changeLanguage(BuildContext context) async {
  int i = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text('选择语言'),
        children: <Widget>[
          SimpleDialogOption(
            child: Text('简体中文'),
            onPressed: () => Navigator.pop(context, 1),
          ),
          SimpleDialogOption(
            child: Text('English'),
            onPressed: () => Navigator.pop(context, 2),
          )
        ],
      );
    }
  );
  print(i);
}

Future<bool> showDeleteConfirmDialog1(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("提示"),
        content: Text("您确定要删除当前文件吗?"),
        actions: <Widget>[
          FlatButton(
            child: Text('取消'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          FlatButton(
            child: Text('确定'),
            onPressed: () {
              // ... 执行操作
              Navigator.of(context).pop(true);
            },
          )
        ],
      );
    }
  );
}