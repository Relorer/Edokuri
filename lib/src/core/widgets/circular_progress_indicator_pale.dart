import 'package:flutter/material.dart';
import 'package:freader/src/theme/theme.dart';

class CircularProgressIndicatorPale extends StatelessWidget {
  const CircularProgressIndicatorPale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).paleElementColor,
      ),
    );
  }
}
