import 'package:flutter/material.dart';
import 'package:freader/src/controllers/stores/repositories/set_repository/set_repository.dart';
import 'package:freader/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:freader/src/core/widgets/sliver_single_child.dart';
import 'package:freader/src/core/widgets/text_form_fields/text_form_field_default.dart';
import 'package:freader/src/core/widgets/second_background_empty_app_bar.dart';
import 'package:freader/src/models/set_records.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:provider/provider.dart';

class SetEditingPage extends StatefulWidget {
  final SetRecords? set;

  const SetEditingPage({Key? key, this.set}) : super(key: key);

  @override
  SetEditingPageState createState() {
    return SetEditingPageState();
  }
}

class SetEditingPageState extends State<SetEditingPage> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.set?.name);
    super.initState();
  }

  void _saveHandler(BuildContext context) {
    final SetRecords setForSave =
        widget.set == null ? SetRecords(controller.text) : widget.set!;
    setForSave.name = controller.text;

    context.read<SetRepository>().putSet(setForSave);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PhantomAppBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: BouncingCustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).secondBackgroundColor,
            title: widget.set == null
                ? const Text("Create set")
                : const Text("Edit set"),
            floating: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.check),
                tooltip: 'Save set',
                onPressed: (() => _saveHandler(context)),
              ),
            ],
          ),
          SliverSingleChild(Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              children: [
                TextFormFieldDefault(
                  controller: controller,
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
