import 'package:flutter/material.dart';
import 'package:freader/src/controllers/stores/db_controller/db_controller.dart';
import 'package:freader/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:freader/src/core/widgets/sliver_single_child.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  SettingsPageState createState() {
    return SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage> {
  late DBController _db;
  final TextEditingController controller = TextEditingController();

  @override
  initState() {
    _db = context.read<DBController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: BouncingCustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).secondBackgroundColor,
            title: const Text("Settings"),
            floating: true,
          ),
          SliverSingleChild(Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              children: [],
            ),
          ))
        ],
      )),
    );
  }
}
