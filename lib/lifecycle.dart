import 'dart:collection';

import 'package:flutter/material.dart';

import 'life_navigator_observer.dart';
import 'lifecycle_mixin.dart';
import 'utils.dart';

class Lifecycle with WidgetsBindingObserver {
  Queue<Route> _routeQueue = new DoubleLinkedQueue();
  Map<Route, LifecycleMixin> _map = {};
  Lifecycle._() {
    WidgetsBinding.instance!.addObserver(this);
  }

  get pageSize => _routeQueue.length;

  ///绑定相关页面进栈
  bindImplIntoRoute(LifecycleMixin lifecycleImpl) {
    bool b = _map.containsKey(_routeQueue.first);
    if (b)
      throw Exception(
          "Lifecycle bindImplIntoRote error: this key is already bound");
    _map[_routeQueue.first] = lifecycleImpl;
  }

  ///解绑，不过页面推出的时候会自动解绑
  unBindImplIntoRoute(LifecycleMixin lifecycleImpl) {
    _map.removeWhere((key, value) => value == lifecycleImpl);
  }

  pushRoute(Route r) {
    _doHide(_routeQueue.isEmpty ? null : _routeQueue.first);
    _routeQueue.addFirst(r);
  }

  Route popRoute() {
    Route removeRoute = _routeQueue.removeFirst();
    _map.removeWhere((key, value) => key == removeRoute);
    _doShow();
    return removeRoute;
  }

  removeRoute(Route r) {
    _map.removeWhere((key, value) => key == r);
    return _routeQueue.removeWhere((element) => element == r);
  }

  replaceRoute(Route? newRoute, Route? oldRoute) {
    _map.removeWhere((key, value) => key == oldRoute);
    _routeQueue =
        Queue.from(_routeQueue.map((e) => e == oldRoute ? newRoute : e));
  }

  ///隐藏时执行到这里
  _doHide(Route? r) {
    if (_routeQueue.isEmpty) return;
    _map.forEach((key, value) {
      if (key == r) {
        value.whenHide();
      }
    });
  }

  ///曝光时执行到这里
  _doShow() {
    printLog(
        content: "_map.length:${_map.length}",
        title: LifeNavigatorObserver.TAG);
    if (_routeQueue.isEmpty) return;
    _map.forEach((key, value) {
      if (key == _routeQueue.first) {
        value.whenShow();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        _doHide(_routeQueue.first);
        break;
      case AppLifecycleState.resumed:
        _doShow();
        break;
      default:
    }
  }
}

Lifecycle lifeCycle = Lifecycle._();
