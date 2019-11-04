/**
 * 
 * Scrollable属性
 * axisDirection: 滚动方向
 * physics: 接受ScrollerPhysics类型对象, 决定滚动组件如何响应用户
 * controller: 接受一个ScrollerController对象. 控制滚动位置和监听属性
 * 
 * Scrollerbar: 滚动条
 * 
 * CupertinoScrollbar: ios风格滚动条
 * 
 * ViewPort视口: 显示区域的总高度
 * 
 * 基于Sliver的延迟构建: 将子组件分成好多sliver, 出现在viewport中的时候, 才构建
 * 支持的组件: ListView, GridView. 不支持的组件: SingleChildScrollView
 * 
 * 滚动的方向是主轴, 非滚动方向是纵轴. 默认主轴为垂直方向
 * 
 */