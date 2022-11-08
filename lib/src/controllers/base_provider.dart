import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

abstract class BaseProvider<C extends Store> extends InheritedWidget {
  final C controller;

  const BaseProvider(
      {super.key, required super.child, required this.controller});

  static P of<P extends InheritedWidget>(BuildContext context) {
    final P? result = context.dependOnInheritedWidgetOfExactType<P>();
    assert(result != null, 'No ${P.runtimeType} found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(oldWidget) => false;
}
