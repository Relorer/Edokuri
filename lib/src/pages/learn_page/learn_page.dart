import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/common/learning_timer_controller/learning_timer_controller.dart';
import 'package:freader/src/controllers/stores/learn_controller/learn_controller.dart';
import 'package:freader/src/core/service_locator.dart';
import 'package:freader/src/core/widgets/provider_sliding_up_panel.dart';
import 'package:freader/src/models/models.dart';
import 'package:freader/src/pages/learn_page/learn_page_app_bar.dart';
import 'package:freader/src/pages/learn_page/learn_page_card_stack.dart';
import 'package:freader/src/pages/learn_page/learn_page_settings.dart';
import 'package:freader/src/theme/system_bars.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

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
                  final int num = _learnController.currentRecord.reviewNumber;
                  final value = 0.15 + 0.85 * (1 - (1 - (7 - min(num, 7)) / 7));
                  return Stack(
                    children: [
                      AnimatedContainer(
                        color: Theme.of(context).unknownWordColor,
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: const Duration(seconds: 1),
                        height: MediaQuery.of(context).size.height * value,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            WaveWidget(
                              config: CustomConfig(
                                gradients: [
                                  [
                                    Theme.of(context)
                                        .savedWordColor
                                        .withOpacity(0.1),
                                    Theme.of(context)
                                        .savedWordColor
                                        .withOpacity(0.6),
                                  ],
                                  [
                                    Theme.of(context)
                                        .savedWordColor
                                        .withOpacity(0.1),
                                    Theme.of(context)
                                        .savedWordColor
                                        .withOpacity(0.6),
                                  ],
                                ],
                                gradientBegin: Alignment.topCenter,
                                gradientEnd: Alignment.bottomCenter,
                                durations: [
                                  10000,
                                  20000,
                                ],
                                heightPercentages: [
                                  0.2,
                                  0.2,
                                ],
                              ),
                              size:
                                  const Size(double.infinity, double.infinity),
                              waveAmplitude: 4,
                            ),
                            Positioned(
                              bottom: -2,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: Theme.of(context).colorScheme.background,
                                alignment: Alignment.bottomCenter,
                                height: 4,
                              ),
                            )
                          ],
                        ),
                      ),
                      AnimatedContainer(
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: const Duration(seconds: 1),
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.only(
                            top:
                                MediaQuery.of(context).size.height * value / 2),
                        height: MediaQuery.of(context).size.height * value,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            WaveWidget(
                              config: CustomConfig(
                                gradients: [
                                  [
                                    Theme.of(context).savedWordColor,
                                    Theme.of(context).colorScheme.background,
                                  ],
                                ],
                                gradientBegin: Alignment.topCenter,
                                gradientEnd: Alignment.bottomCenter,
                                durations: [
                                  36000,
                                ],
                                heightPercentages: [
                                  0.5,
                                ],
                              ),
                              size:
                                  const Size(double.infinity, double.infinity),
                              waveAmplitude: 4,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: LearnPageAppBar(
                      settingsClick: () => _panelController.open()),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 80 + doubleDefaultMargin),
                  child: LearnPageCardStack(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
