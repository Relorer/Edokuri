import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/common/learning_timer_controller/learning_timer_controller.dart';
import 'package:freader/src/controllers/stores/learn_controller/learn_controller.dart';
import 'package:freader/src/core/service_locator.dart';
import 'package:freader/src/core/widgets/provider_sliding_up_panel.dart';
import 'package:freader/src/models/models.dart';
import 'package:freader/src/pages/learn_page/learn_page_app_bar.dart';
import 'package:freader/src/pages/learn_page/learn_page_settings.dart';
import 'package:freader/src/theme/system_bars.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

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
  late LearningTimerController learningTimer;

  @override
  void didChangeMetrics() {
    if (mounted) {
      setUpBarReaderStyles(context);
    }
    super.didChangeMetrics();
  }

  @override
  void initState() {
    learningTimer = getIt<LearningTimerController>();
    _learnController = getIt<LearnController>(param1: widget.records);

    learningTimer.startReadingTimer();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        learningTimer.stopReadingTimer();
        break;
      case AppLifecycleState.resumed:
        learningTimer.startReadingTimer();
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    learningTimer.stopReadingTimer();
    super.dispose();
  }

  final Random random = Random();
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
          body: Container(
            color: Theme.of(context).colorScheme.background,
            child: Stack(
              children: [
                Observer(builder: (_) {
                  final num = _learnController.currentRecord.reviewNumber;
                  final value = 0.15 + 0.85 * (1 - (1 - (7 - min(num, 7)) / 7));
                  return AnimatedContainer(
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: const Duration(seconds: 1),
                    height: MediaQuery.of(context).size.height * value,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          key: ValueKey(_learnController.currentRecord.id),
                          child: WaveWidget(
                            wavePhase: 100 * value,
                            backgroundColor: Theme.of(context).unknownWordColor,
                            config: CustomConfig(
                              colors: [
                                Theme.of(context)
                                    .savedWordColor
                                    .withOpacity(0.3),
                                Theme.of(context)
                                    .savedWordColor
                                    .withOpacity(0.6),
                                Theme.of(context).colorScheme.background,
                              ],
                              durations: [
                                10000,
                                20000,
                                30000,
                              ],
                              heightPercentages: [
                                0.2,
                                0.5,
                                0.7,
                              ],
                            ),
                            size: const Size(double.infinity, double.infinity),
                            waveAmplitude: 4,
                          ),
                        ),
                        Positioned(
                          bottom: -4,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Theme.of(context).colorScheme.background,
                            alignment: Alignment.bottomCenter,
                            height: 8,
                          ),
                        )
                      ],
                    ),
                  );
                }),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: LearnPageAppBar(
                      settingsClick: () => _panelController.open()),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 80 + doubleDefaultMargin),
                  child: LearnPageCardSwiper(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
