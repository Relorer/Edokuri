// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/stores/pocketbase/pocketbase_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_block_container.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class SettingsPageProfile extends StatelessWidget {
  const SettingsPageProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final pocketbase = getIt<PocketbaseController>();
    final user = pocketbase.user;

    final name = user?.name != "" ? user?.name ?? "Unknown" : "Unknown";
    final email = user?.email == "" ? null : user?.email;

    return SliverSingleChild(Material(
      color: Colors.transparent,
      child: SettingsPageBlockContainer(
        child: Observer(builder: (context) {
          return Column(children: [
            const SizedBox(
              height: doubleDefaultMargin,
            ),
            user != null && user.avatar != null
                ? Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                      image: DecorationImage(
                          fit: BoxFit.cover, image: MemoryImage(user.avatar!)),
                    ),
                  )
                : Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/profile.png")),
                    ),
                  ),
            Text(
              name,
              style: const TextStyle(
                  fontSize: 18,
                  color: darkGray,
                  fontWeight: FontWeight.w900,
                  height: 1.5),
            ),
            email != null
                ? Text(
                    email,
                    style: const TextStyle(
                        fontSize: 14,
                        color: darkGray,
                        fontWeight: FontWeight.w500,
                        height: 1.5),
                  )
                : const SizedBox(),
            const SizedBox(
              height: doubleDefaultMargin,
            ),
          ]);
        }),
      ),
    ));
  }
}
