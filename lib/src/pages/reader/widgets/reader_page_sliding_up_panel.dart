import 'package:flutter/material.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ReaderPageSlidingUpPanel extends StatelessWidget {
  final PanelController controller;
  final Widget body;
  final Widget Function(ScrollController)? panelBuilder;
  final bool blockBody;
  final VoidCallback? panelCloseHandler;
  final VoidCallback? panelOpenHandler;

  const ReaderPageSlidingUpPanel(
      {super.key,
      required this.body,
      required this.panelBuilder,
      required this.controller,
      required this.blockBody,
      this.panelCloseHandler,
      this.panelOpenHandler});

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      onPanelClosed: panelCloseHandler,
      onPanelOpened: panelOpenHandler,
      controller: controller,
      minHeight: 0,
      maxHeight: MediaQuery.of(context).size.height * 0.75,
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
      body: Stack(
        children: [
          body,
          Container(
            color: Colors.amber,
            height: blockBody ? null : 0,
          )
        ],
      ),
    );
  }
}
