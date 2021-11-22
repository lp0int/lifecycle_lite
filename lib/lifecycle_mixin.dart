import 'lifecycle.dart';

mixin LifecycleMixin {
  bindImplIntoRoute() {
    lifeCycle.bindImplIntoRoute(this);
  }

  void whenShow() {}
  void whenHide() {}
}
