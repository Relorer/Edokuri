// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/theme/theme.dart';

class AddRecordPage extends StatefulWidget {
  final String setName;
  const AddRecordPage({Key? key, required this.setName}) : super(key: key);

  @override
  AddRecordPageState createState() {
    return AddRecordPageState();
  }
}

class AddRecordPageState extends State<AddRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondBackgroundColor,
        elevation: 0,
        title: Text("Add to ${widget.setName}"),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(child: Container()),
    );
  }
}
