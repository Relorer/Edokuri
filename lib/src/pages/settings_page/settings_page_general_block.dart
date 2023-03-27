// 🐦 Flutter imports:
import 'package:edokuri/src/theme/theme_consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/toast_controller/toast_controller.dart';
import 'package:edokuri/src/controllers/stores/ml_controller/ml_controller.dart';
import 'package:edokuri/src/core/service_locator.dart';
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_block_container.dart';
import 'package:edokuri/src/pages/settings_page/settings_page_button.dart';
import 'package:edokuri/src/theme/svgs.dart';

class SettingsPageGeneralBlock extends StatelessWidget {
  const SettingsPageGeneralBlock({super.key});
  void checkStateDownloadModel() async {
    if (!getIt<MLController>().isLoaded) {
      await getIt<MLController>().downloadModels();
      getIt<ToastController>().showDefaultTost("Language model is downloaded");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverSingleChild(Material(
      color: Colors.transparent,
      child: SettingsPageBlockContainer(
        child: Column(
          children: [
            SizedBox(
              height: defaultRadius,
            ),
            getIt<MLController>().isLoaded && false
                ? SizedBox()
                : SettingPageButton(
                    text: "Load the language model",
                    onTap: checkStateDownloadModel,
                    svg: translateSvg,
                  ),
                  SizedBox(
              height: defaultRadius,
            ),
          ],
        ),
      ),
    ));
  }
}
