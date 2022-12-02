import 'package:flutter/material.dart';
import 'package:freader/src/controllers/stores/learn_controller/learn_controller.dart';
import 'package:freader/src/core/service_locator.dart';
import 'package:freader/src/core/widgets/provider_sliding_up_panel.dart';
import 'package:freader/src/models/models.dart';
import 'package:freader/src/pages/learn_page/learn_page_app_bar.dart';
import 'package:freader/src/pages/learn_page/learn_page_settings.dart';
import 'package:freader/src/theme/system_bars.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'learn_page_card_swiper.dart';

class LearnPage extends StatefulWidget {
  final List<Record> records;

  const LearnPage({Key? key, required this.records}) : super(key: key);

  @override
  LearnPageState createState() {
    return LearnPageState();
  }
}

class LearnPageState extends State<LearnPage> with WidgetsBindingObserver {
  final PanelController _panelController = PanelController();
  late LearnController _learnController;

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
    _learnController = getIt<LearnController>(param1: widget.records);
  }

  @override
  Widget build(BuildContext context) {
    setUpBarReaderStyles(context);

    return Material(
      child: MultiProvider(
        providers: [
          Provider<LearnController>(create: (_) => _learnController),
        ],
        child: ProviderSlidingUpPanel(
          height: 300,
          backdropOpacity: 0.2,
          controller: _panelController,
          panelBuilder: (ScrollController sc) => const LearnPageSettings(),
          body: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar:
                LearnPageAppBar(settingsClick: () => _panelController.open()),
            body: const LearnPageCardSwiper(),
          ),
        ),
      ),
    );
  }
}
