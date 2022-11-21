import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:freader/src/controllers/db_controller/db_controller.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';

class RecordsScreenRecordsCards extends StatelessWidget {
  const RecordsScreenRecordsCards({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<DBController>();
    final records = db.records.where((element) => !element.known).toList();

    return Expanded(
      child: Swiper(
        curve: Curves.bounceInOut,
        viewportFraction: 0.85,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultMargin, vertical: doubleDefaultMargin),
            child: Transform.scale(
                scale: 1,
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
                      child: Center(
                          child: AutoSizeText(
                        records[index].original.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: Colors.black87),
                        maxLines: 8,
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
                      child: Center(
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
                    ),
                  ),
                )),
          );
        },
        itemCount: records.length,
      ),
    );
  }
}
