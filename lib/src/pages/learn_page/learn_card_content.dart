import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/default_card_container.dart';
import 'package:freader/src/models/models.dart';
import 'package:freader/src/theme/theme_consts.dart';

class LearnCardContent extends StatelessWidget {
  final Record record;

  const LearnCardContent({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(doubleDefaultMargin),
      child: Positioned.fill(
        child: DefaultCardContainer(
          Material(
            color: Colors.transparent,
            child: Column(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(doubleDefaultMargin),
                  child: Center(
                    child: AutoSizeText(
                      record.original,
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
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
          ),
        ),
      ),
    );
  }
}
