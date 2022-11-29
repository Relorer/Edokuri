import 'package:flutter/material.dart';
import 'package:freader/objectbox.g.dart';
import 'package:freader/src/core/widgets/default_card_container.dart';
import 'package:freader/src/core/widgets/provider_sliding_up_panel.dart';
import 'package:freader/src/models/models.dart';
import 'package:freader/src/pages/learn_page/learn_card_content.dart';
import 'package:freader/src/pages/learn_page/learn_swipable_stack.dart';
import 'package:freader/src/theme/system_bars.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:swipable_stack/swipable_stack.dart';

class LearnPage extends StatefulWidget {
  final List<Record> records;

  const LearnPage({Key? key, required this.records}) : super(key: key);

  @override
  LearnPageState createState() {
    return LearnPageState();
  }
}

class LearnPageState extends State<LearnPage> with WidgetsBindingObserver {
  late final SwipableStackController _controller;
  final PanelController _panelController = PanelController();

  void _listenController() => setState(() {});

  @override
  void didChangeMetrics() {
    if (mounted) {
      setUpBarReaderStyles(context);
    }
    super.didChangeMetrics();
  }

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController()..addListener(_listenController);
  }

  @override
  void dispose() {
    super.dispose();
    _controller
      ..removeListener(_listenController)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    setUpBarReaderStyles(context);

    return Material(
      child: ProviderSlidingUpPanel(
        backdropOpacity: 0.2,
        controller: _panelController,
        panelBuilder: (ScrollController sc) => ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(defaultRadius),
            topRight: Radius.circular(defaultRadius),
          ),
          child: Container(
              color: Theme.of(context).colorScheme.background,
              child: Column(
                children: [
                  SizedBox(
                    height: defaultMargin,
                  ),
                  Container(
                    height: 4,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Theme.of(context).paleElementColor,
                        borderRadius:
                            BorderRadius.all(Radius.circular(defaultRadius))),
                  ),
                  SizedBox(
                    height: defaultMargin,
                  ),
                ],
              )),
        ),
        body: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            elevation: 0,
            foregroundColor: Theme.of(context).secondBackgroundColor,
            title: Center(child: Text("1/2")),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => _panelController.open(),
              ),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: 0.1,
                  backgroundColor:
                      Theme.of(context).paleElementColor.withOpacity(0.3),
                ),
                Expanded(
                  child: LearnSwipableStack(
                    builder: (context, properties) => LearnCardContent(
                      record: widget
                          .records[properties.index % widget.records.length],
                    ),
                    right: const DefaultCardContainer(
                      Center(
                          child: Text(
                        "Know",
                        style: TextStyle(
                            fontSize: 32,
                            color: Color(0xff14B220),
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    left: const DefaultCardContainer(
                      Center(
                          child: Text(
                        "Still learning",
                        style: TextStyle(
                            fontSize: 32,
                            color: savedWord,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
