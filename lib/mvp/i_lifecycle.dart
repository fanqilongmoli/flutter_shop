abstract class ILifeCycle {
  /// 插入到渲染树时调用，只执行一次。（类似Android Fragment的onCreateView函数）
  void initState();

  /// 1、在初始化initState后执行； 2、显示/关闭其它widget。 3、可执行多次；
  void didChangeDependencies();

  /// 上级节点rebuild widget时， 即上级组件状态发生变化时会触发子widget执行didUpdateWidget;
  void didUpdateWidgets<W>(W oldWidget);

  /// 有点像Android的onStop函数， 在打开新的Widget或回到这个widget时会执行； 可执行多次；
  void deactivate();

  /// 类似于Android的onDestroy， 在执行Navigator.pop后会调用该办法， 表示组件已销毁；
  void dispose();
}
