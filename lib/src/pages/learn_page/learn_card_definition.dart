import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/models/models.dart';
import 'package:freader/src/theme/theme_consts.dart';

class LearnCardDefinition extends StatelessWidget {
  final Record record;

  const LearnCardDefinition({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(children: [
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(doubleDefaultMargin),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                    child: AutoSizeText(
                      record.translation,
                      maxLines: record.translation.contains(" ") ? null : 1,
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: IconButton(
                icon: const Icon(Icons.keyboard),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: IconButton(
                icon: const Icon(Icons.remove_red_eye),
                onPressed: () {},
              ),
            ),
          ],
        ),
        const SizedBox(
          height: doubleDefaultMargin,
        )
      ]),
    );
  }
}
