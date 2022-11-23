import 'package:flutter/material.dart';
import 'package:freader/src/controllers/stores/db_controller/db_controller.dart';
import 'package:freader/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:freader/src/core/widgets/sliver_single_child.dart';
import 'package:freader/src/core/widgets/text_form_field_default.dart';
import 'package:freader/src/theme/system_bars.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';

class SetEditingPage extends StatefulWidget {
  const SetEditingPage({
    Key? key,
  }) : super(key: key);

  @override
  SetEditingPageState createState() {
    return SetEditingPageState();
  }
}

class SetEditingPageState extends State<SetEditingPage> {
  late DBController _db;

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
            title: const Text("Create set"),
            floating: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.check),
                tooltip: 'Save set',
                onPressed: () {},
              ),
            ],
          ),
          SliverSingleChild(Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              children: [
                TextFormFieldDefault(
                  onFieldSubmitted: ((value) {}),
                  labelText: 'Enter set name',
                ),
              ],
            ),
          ))
        ],
      )),
    );
  }
}
