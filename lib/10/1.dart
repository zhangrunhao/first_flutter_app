
/**
 * 自定义组件的方式:
 * 1. 组合其他widget成为一个新的widget
 * 2. 自绘: 使用CustomPaint和Canvas进行自绘
 * 3. 实现RenderObject: 最终也是通过调用CanvasAPI进行绘制.
 * 
 * 区别:
 * 自绘和实现RenderObject在本质上是一样的, 都是通过Canvas实现的.
 * CustomPaint 为了方便开发者封装的一个代理类, 它直接继承自 SingleChildRenderObjectWidget.
 * 通过RnderCustomPaint的paint方法将Canvas和画笔Painter(开发者实现)连接起来.
 */