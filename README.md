# lifecycle_lite
通过简单几步，就可以让你使用whenShow()/whenHide()方法来监听**页面**的生命周期(退回到了该页面/打开其他页面挡着了该页面)了

## Principle
这个库的实现很简单，你完全可以通过阅读代码后自己扩展实现。主要就是在`MaterialApp`中添加一个对路由的监听，也就是`MaterialApp#navigatorObservers`，之后通过对路由的监听来记录一个路由的栈。再在对应的`State#initState`方法或`StatelessWidget#createElement`中绑定两个生命周期方法的实现到最上层路由。
这样在每次监听到路由变化时，去调用顶层路由对应的绑定方法就OK了。
记得在路由被移出的时候对应的方法也要移出哦~

- [x] StatefulWidget
- [x] StatelessWidget

## Getting Started
>`lifecycle_lite: ^0.0.3`  

1.首先在你的根布局`MaterialApp`中绑定一个路由监听`LifeNavigatorObserver()`.
```dart
    MaterialApp(
        navigatorObservers: [
            LifeNavigatorObserver(),
        ],
    );
```
~~2.在你需要添加监听的`State`中混入`LifecycleMixin`,并在`initState`中调用`bindImplIntoRoute()`方法。~~

2.`StatefulWidget`的话，需要混入`LifecycleStatefulMixin`，对应的`StatelessWidget`，使用的是`LifecycleStatelessMixin`

3.实现`whenShow()/whenHide()`方法,代码看起来是下面的样子。
```dart
///Statefule page
class WorksDetailState extends State with LifecycleStatefulMixin{

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
///Stateless page
class StatelessPage extends StatelessWidget with LifecycleStatelessMixin{

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
