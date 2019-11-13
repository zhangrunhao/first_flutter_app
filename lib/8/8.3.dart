// 订阅者回调签名
typedef void EventCallback(arg);

class EventBus {
  /**
   * TODO: 不能理解static变量, 和工厂构造函数, 已经这样做发生了什么.
   * 书中解释的是: 
   * Dart中实现单例模式的标准做法
   * 使用static变量 + 工厂构造函数. 保证new EventBus()返回的是同一个实例
   */
  // 私有构造函数
  EventBus._internal();

  // 保存单例
  static EventBus _singleton = new EventBus._internal();

  // 工厂构造函数
  factory EventBus () => _singleton;

  // 保存事件订阅者队列, key(事件名, id), value(对应事件的订阅者队列)
  var _emap = new Map<Object, List<EventCallback>>();

  // 添加订阅者
  void add(String eventName, EventCallback f) {
    if (eventName == null || f == null) return;
    // ?? 判断是否存在, 不存在就初始化一个?
    _emap[eventName] ??= new List<EventCallback>();
    _emap[eventName].add(f);
  }

  // 移出订阅者
  void off(String eventName, [EventCallback f]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) return;
    if (f == null) {
      _emap[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  // 触发事件
  void emit(String eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null) return;
    int len = list.length - 1;
    for(var i = len; i >= 0; --i) {
      list[i](arg);
    }
  }
}