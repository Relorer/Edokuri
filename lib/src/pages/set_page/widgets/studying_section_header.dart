import 'package:flutter/material.dart';
import 'package:edokuri/src/core/widgets/section_headers/section_header_text.dart';

class StudyingSectionHeader extends StatelessWidget {
  const StudyingSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionHeaderText(
      leftText: "Continue studying",
    );
  }
}
