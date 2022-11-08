import 'package:flutter/material.dart';
import 'package:freader/src/theme/theme.dart';

class GraphWidget extends StatelessWidget {
  const GraphWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox.expand(
        child: Container(
          color: Theme.of(context).paleElementColor,
        ),
      ),
    );
  }
}
