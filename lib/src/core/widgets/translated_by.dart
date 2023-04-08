// 🐦 Flutter imports:
import 'package:flutter/widgets.dart';

// 📦 Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// 🌎 Project imports:
import 'package:edokuri/src/controllers/common/translator_controller/translate_source.dart';
import 'package:edokuri/src/theme/svgs.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class TranslatedBy extends StatelessWidget {
  final String source;

  const TranslatedBy({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    Widget translatedBy = const SizedBox();

    if (source == googleSource || source == googleMlSource) {
      translatedBy = SvgPicture.asset(
        translatedByGoogleSvg,
        height: 12,
      );
    } else if (source == yandexSource) {
      translatedBy = SvgPicture.asset(
        yaLogoSvg,
        height: 12,
      );
    } else if (source == deeplSource) {
      translatedBy = SvgPicture.asset(
        deeplLogoSvg,
        height: 18,
      );
    }

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: defaultMargin),
        child: translatedBy);
  }
}
