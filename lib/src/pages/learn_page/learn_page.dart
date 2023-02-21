import 'package:flutter/material.dart';
import 'package:freader/src/models/models.dart';

class LearnPage extends StatefulWidget {
  final List<Record> records;

  const LearnPage({Key? key, required this.records}) : super(key: key);

  @override
  LearnPageState createState() {
    return LearnPageState();
  }
}

class LearnPageState extends State<LearnPage> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {

    return const Text("Learn");
  }
}
