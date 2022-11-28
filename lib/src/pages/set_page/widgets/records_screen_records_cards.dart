import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:freader/src/controllers/stores/set_controller/set_controller.dart';
import 'package:freader/src/models/record.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RecordsScreenRecordsCards extends StatefulWidget {
  final SetData setData;

  const RecordsScreenRecordsCards({super.key, required this.setData});

  @override
  State<RecordsScreenRecordsCards> createState() =>
      _RecordsScreenRecordsCardsState();
}

class _RecordsScreenRecordsCardsState extends State<RecordsScreenRecordsCards> {
  late List<Record> _records;
  @override
  void initState() {
    _records = widget.setData.records.toList()..shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_records.isEmpty) {
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
                  count: _records.length,
                  effect: ScrollingDotsEffect(
                      fixedCenter: true,
                      outlinedCenter: false,
                      dotHeight: defaultMargin * 0.6,
                      dotWidth: defaultMargin * 0.6,
                      dotColor: Theme.of(context).paleElementColor,
                      activeDotColor: Theme.of(context).brightElementColor),
                  onDotClicked: (index) {}),
            ),
          );
        }),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(
                top: doubleDefaultMargin, bottom: doubleDefaultMargin),
            child: FlipCard(
              speed: 350,
              fill: Fill.fillBack,
              direction: FlipDirection.VERTICAL,
              front: Container(
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
                          _records[index].original.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(color: Colors.black87),
                          maxLines: 8,
                        )),
                      ],
                    )),
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
                          _records[index]
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
        itemCount: _records.length,
      ),
    );
  }
}
