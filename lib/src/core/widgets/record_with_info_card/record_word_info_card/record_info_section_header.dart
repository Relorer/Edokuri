import 'package:flutter/widgets.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class RecordInfoSectionHeader extends StatelessWidget {
  final String title;

  const RecordInfoSectionHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultMargin),
      child: SizedBox(
          width: double.maxFinite,
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
    );
  }
}
