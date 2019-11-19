/**
 * 
 * Animation: 
 * 保存动画的插值和状态.
 * 在一段时间内 依次生成 一个Tween之间的值 的类.
 * 由Curve决定线性, 进步函数, 或其他曲线函数.
 * 根据控制方式, 决定正向, 反向, 中间切换方向.
 * 动画中, 每一帧可以通过value属性获取当前状态值
 * addListener()监听动画每一帧刷新, setState更改UI
 * addStatusListener()监听动画状态的改变.
 * 
 * 
 * Curve:
 * 描述动画的过程.
 * 
 * AnimationController:
 * 用于控制动画, 包括动画的启动, 停止, 反向操作等.
 * 在动画的每一帧, 都会生成一个新的值.
 * 可以生成一个默认区间0-1, 区间可以更改. 线性的生成这个区间, 猜测表示动画执行到的步骤
 * 特殊情况下回超过这个范围. 如甩出
 * // TODO: 为什么派生自某个类, 就可以在需要这个类的任何地方使用了呢?
 * 派生自Animation<doubule>, 因此可以在需要Animation对象的任何地方使用.
 * 
 * 
 * Ticker:
 * 创建AnimationController, 需要传入vsync, 便是TickerProvider类型
 * Flutter启动时, 绑定schedulerBinding
 * ticker是scheduleBinding驱动的. 可以避免UI外, 如锁屏时候的消耗
 * 
 * Tween:
 * 用来生成不同范围或数据类型的值.
 * 不存储任何状态.
 * 提供 evaluate 方法, 可以获取动画当前值.
 * 
 */

// 500毫秒, 创建0-255整数值
// TODO: 不明白this的含义? 不明白类型加泛型的意义? 不明白这段代码的具体使用意义
// final AnimationController controller = new AnimationController(
//   duration: Duration(milliseconds: 500),
//   vsync: this,
// );

// Animation<int> alpha = new IntTween(begin: 0, end: 255).animate(controller);

// * 创建一个控制器, 一条取消, 和一个Tween

// final AnimationController controller = AnimationController(
//   duration: Duration(milliseconds: 500),
//   vsync: this
// );
// final Animation curve = CurvedAnimation(
//   parent: controller,
//   curve: Curves.ease
// );
// // TODO: 不明白这最后在做什么..
// Animation<int> alpha = IntTween(begin: 0, end: 255).animate(curve);
