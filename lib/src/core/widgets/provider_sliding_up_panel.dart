// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:sliding_up_panel/sliding_up_panel.dart';

// Project imports:
import 'package:edokuri/src/theme/theme_consts.dart';

class ProviderSlidingUpPanel extends StatelessWidget {
  final PanelController? controller;
  final Widget body;
  final Widget Function(ScrollController)? panelBuilder;
  final VoidCallback? panelCloseHandler;
  final VoidCallback? panelOpenHandler;
  final double backdropOpacity;

  final double? height;

  const ProviderSlidingUpPanel(
      {super.key,
      required this.body,
      required this.panelBuilder,
      this.controller,
      this.backdropOpacity = 0,
      this.panelCloseHandler,
      this.panelOpenHandler,
      this.height});

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
        backdropEnabled: true,
        backdropOpacity: backdropOpacity,
        onPanelClosed: panelCloseHandler,
        onPanelOpened: panelOpenHandler,
        controller: controller,
        minHeight: 0,
        maxHeight: height ?? MediaQuery.of(context).size.height * 0.75,
        renderPanelSheet: false,
        boxShadow: const [
          BoxShadow(
            blurRadius: 10.0,
            color: Color.fromRGBO(0, 0, 0, 0.25),
          )
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(defaultRadius),
          topRight: Radius.circular(defaultRadius),
        ),
        color: Theme.of(context).colorScheme.background,
        panelBuilder: panelBuilder,
        body: body);
  }
}
