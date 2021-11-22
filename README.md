# lifecycle_lite
通过简单几步，就可以让你使用whenShow()/whenHide()方法来监听页面的生命周期了

## Principle
这个库的实现很简单，你完全可以通过阅读代码后自己扩展实现。主要就是在`MaterialApp`中添加一个对路由的监听，也就是`MaterialApp#navigatorObservers`，之后通过对路由的监听来记录一个路由的栈。再在对应的`State#initState`方法中绑定两个生命周期方法的实现到最上层路由。
这样在每次监听到路由变化时，去调用顶层路由对应的绑定方法就OK了。
记得在路由被移出的时候对应的方法也要移出哦~

## Getting Started
>`
import 'package:lifecycle/lifecycle_mixin.dart';`  

1.首先在你的根布局`MaterialApp`中绑定一个路由监听`LifeNavigatorObserver()`.
```dart
    MaterialApp(
        navigatorObservers: [
            LifeNavigatorObserver(),
        ],
    );
```
2.在你需要添加监听的`State`中混入`LifecycleMixin`,并在`initState`中调用`bindImplIntoRoute()`方法。


3.实现`whenShow()/whenHide()`方法,代码看起来是下面的样子。
```dart
class WorksDetailState extends State with LifecycleMixin{
    @override
    void initState() {
        super.initState();
        bindImplIntoRoute();
    }

    @override
    whenShow() {
        super.whenShow();
        print("LifeNavigatorObserver---Show了");
    }

    @override
    whenHide() {
        super.whenHide();
        print("LifeNavigatorObserver---Hide了");
    }
}
```

尽情享用吧  :P;
