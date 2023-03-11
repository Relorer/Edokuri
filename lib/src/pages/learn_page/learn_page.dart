// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/theme/theme.dart';

class LearnPage extends StatefulWidget {
  final List<Record> records;
  const LearnPage({Key? key, required this.records}) : super(key: key);

  @override
  LearnPageState createState() {
    return LearnPageState();
  }
}

class LearnPageState extends State<LearnPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondBackgroundColor,
        elevation: 0,
        title: const Text("All"),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(child: Container()),
    );
  }
}
