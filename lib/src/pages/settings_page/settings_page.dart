// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:edokuri/src/core/widgets/button_with_icon.dart';
import 'package:edokuri/src/core/widgets/second_background_empty_app_bar.dart';
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme.dart';

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
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PhantomAppBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: BouncingCustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).secondBackgroundColor,
            title: const Text("Settings"),
            floating: true,
          ),
          SliverSingleChild(Column(
            children: [
              ButtonWithIcon(
                text: "Sign out",
                onTap: () async {
                  await getIt<PocketbaseController>().logout();
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                svg: exitSvg,
              ),
            ],
          ))
        ],
      )),
    );
  }
}
