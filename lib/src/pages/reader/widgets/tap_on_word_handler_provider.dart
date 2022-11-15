import 'package:flutter/widgets.dart';

class TapOnWordHandlerProvider extends InheritedWidget {
  final Function(String) tapOnWordHandler;

  const TapOnWordHandlerProvider(
      {super.key, required super.child, required this.tapOnWordHandler});

  static TapOnWordHandlerProvider of(BuildContext context) {
    final TapOnWordHandlerProvider? result =
        context.dependOnInheritedWidgetOfExactType<TapOnWordHandlerProvider>();
    assert(result != null, 'No TapOnWordHandlerProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(oldWidget) => false;
}
