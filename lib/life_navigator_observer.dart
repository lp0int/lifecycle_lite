import 'package:flutter/material.dart';

import './lifecycle_export.dart';
import './utils.dart';

class LifeNavigatorObserver extends NavigatorObserver {
  static const TAG = "LifeNavigatorObserver";
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    lifeCycle.popRoute();
    printLog(title: TAG, content: "didPop-result_length:${lifeCycle.pageSize}");
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    lifeCycle.pushRoute(route);
    printLog(
        title: TAG, content: "didPush-result_length:${lifeCycle.pageSize}");
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    lifeCycle.removeRoute(route);
    printLog(
        title: TAG, content: "didRemove-result_length:${lifeCycle.pageSize}");
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    lifeCycle.replaceRoute(newRoute, oldRoute);
    printLog(
        title: TAG, content: "didReplace-result_length:${lifeCycle.pageSize}");
  }
}
