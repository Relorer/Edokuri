import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:freader/src/controllers/db_controller/db_controller.dart';
import 'package:freader/src/core/utils/records_list_extensions.dart';
import 'package:freader/src/theme/svgs.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RecordsScreenRecordsCards extends StatelessWidget {
  const RecordsScreenRecordsCards({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<DBController>();
    if (db.records.saved.isEmpty) {
      return Container();
    }
    final records = db.records.saved..shuffle();

    return Expanded(
      child: Padding(
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
                fill: Fill.fillBack,
                direction: FlipDirection.HORIZONTAL,
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
                            records[index].original.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(color: Colors.black87),
                            maxLines: 8,
                          )),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: SvgPicture.asset(
                              cropSvg,
                              height: doubleDefaultMargin * 0.8,
                              color: Theme.of(context)
                                  .paleElementColor
                                  .withOpacity(0.7),
                            ),
                          )
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
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: SvgPicture.asset(
                              cropSvg,
                              height: doubleDefaultMargin * 0.8,
                              color: Theme.of(context)
                                  .paleElementColor
                                  .withOpacity(0.7),
                            ),
                          )
                        ],
                      )),
                ),
              ),
            );
          },
          itemCount: records.length,
        ),
      ),
    );
  }
}
