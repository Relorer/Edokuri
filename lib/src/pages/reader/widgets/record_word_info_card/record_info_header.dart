import 'package:flutter/material.dart';

class RecordInfoHeader extends StatelessWidget {
  final String title;

  const RecordInfoHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Text(
        title.contains(" ") ? title : title.toUpperCase(),
        textAlign: title.contains("\n") ? TextAlign.left : TextAlign.center,
        style: const TextStyle(
            fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
      ),
    );
  }
}
