// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/tts_controller/tts_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class RecordsScreenRecordsCards extends StatelessWidget {
  final SetData setData;

  const RecordsScreenRecordsCards({super.key, required this.setData});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final records = setData.records.toList()..shuffle();

      if (records.isEmpty) {
        return Container();
      }
      return Padding(
        padding: const EdgeInsets.only(bottom: doubleDefaultMargin),
        child: Swiper(
          curve: Curves.bounceInOut,
          loop: false,
          viewportFraction: 0.85,
          scale: 0.9,
          pagination: SwiperCustomPagination(
              builder: (BuildContext context, SwiperPluginConfig config) {
            return Container(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                child: SmoothPageIndicator(
                    controller: config.pageController!,
                    count: records.length,
                    effect: ScrollingDotsEffect(
                        fixedCenter: true,
                        outlinedCenter: false,
                        dotHeight: defaultMargin * 0.6,
                        dotWidth: defaultMargin * 0.6,
                        dotColor: Theme.of(context).lightGrayColor,
                        activeDotColor: Theme.of(context).brightElementColor),
                    onDotClicked: (index) {}),
              ),
            );
          }),
          itemBuilder: (BuildContext _, int index) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: doubleDefaultMargin, bottom: doubleDefaultMargin),
              child: FlipCard(
                speed: 350,
                fill: Fill.fillBack,
                direction: FlipDirection.VERTICAL,
                front: GestureDetector(
                  onLongPress: () {
                    getIt<TTSController>().speak(records[index].original);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(defaultRadius / 2),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(doubleDefaultMargin),
                        child: Stack(
                          children: [
                            Center(
                                child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AutoSizeText(
                                  records[index].original.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(color: Colors.black87),
                                  maxLines: 8,
                                ),
                                records[index].transcription.isEmpty
                                    ? Container()
                                    : AutoSizeText(
                                        records[index].transcription,
                                        style:
                                            Theme.of(context).cardSubtitleStyle,
                                      )
                              ],
                            )),
                          ],
                        )),
                  ),
                ),
                back: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(defaultRadius / 2),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(doubleDefaultMargin),
                      child: Stack(
                        children: [
                          Center(
                              child: AutoSizeText(
                            records[index]
                                .translations
                                .where((element) => element.selected)
                                .map((e) => e.text)
                                .join(", ")
                                .toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(color: Colors.black87),
                            maxLines: 8,
                          )),
                        ],
                      )),
                ),
              ),
            );
          },
          itemCount: records.length,
        ),
      );
    });
  }
}
