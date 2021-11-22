import 'package:flutter/material.dart';

import 'lifecycle.dart';

mixin LifecycleMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    lifeCycle.bindImplIntoRoute(this);
  }

  //now we dont need call this method
  @deprecated
  bindImplIntoRoute() {
    lifeCycle.bindImplIntoRoute(this);
  }

  void whenShow() {}
  void whenHide() {}
}
