// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/repositories/repositories.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:edokuri/src/core/widgets/safe_area_with_settings.dart';
import 'package:edokuri/src/core/widgets/second_background_empty_app_bar.dart';
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/core/widgets/text_form_fields/text_form_field_default.dart';
import 'package:edokuri/src/models/models.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

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
        widget.set == null ? SetRecords(name: controller.text) : widget.set!;
    setForSave.name = controller.text.trim();

    getIt<SetRecordsRepository>().putSet(setForSave);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).secondBackgroundColor,
      child: SafeAreaWithSettings(
        child: Scaffold(
          appBar: const PhantomAppBar(),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: BouncingCustomScrollView(
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
          ),
        ),
      ),
    );
  }
}
