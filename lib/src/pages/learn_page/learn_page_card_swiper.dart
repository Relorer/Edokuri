import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/stores/learn_controller/learn_controller.dart';
import 'package:freader/src/pages/learn_page/learn_page_card_stack.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:provider/provider.dart';

class LearnPageCardSwiper extends StatelessWidget {
  const LearnPageCardSwiper({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Observer(builder: (_) {
            final learn = context.read<LearnController>();
            return LinearProgressIndicator(
              value: learn.currentRecord / learn.records.length,
              backgroundColor:
                  Theme.of(context).paleElementColor.withOpacity(0.3),
            );
          }),
          const Expanded(
            child: LearnPageCardStack(),
          ),
        ],
      ),
    );
  }
}
