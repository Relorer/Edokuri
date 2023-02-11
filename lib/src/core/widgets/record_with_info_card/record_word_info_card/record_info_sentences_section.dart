import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freader/src/models/record.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/record_with_info_card/record_word_info_card/record_info_section_header.dart';
import 'package:freader/src/theme/svgs.dart';
import 'package:freader/src/theme/theme_consts.dart';

class RecordInfoSentencesSection extends StatelessWidget {
  final bool showTranslation;
  final List<Example> sentences;

  const RecordInfoSentencesSection(
      {super.key, required this.sentences, required this.showTranslation});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const RecordInfoSectionHeader("Sentences"),
        ...sentences.map((element) => Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                    width: double.maxFinite,
                    child: Text(element.text,
                        style: const TextStyle(
                          fontSize: 14,
                        ))),
                showTranslation
                    ? Column(
                        children: [
                          SizedBox(
                              width: double.maxFinite,
                              child: Text(element.tr,
                                  style: const TextStyle(
                                      fontSize: 14, color: paleElement))),
                          SizedBox(
                            height: sentences.indexOf(element) ==
                                    sentences.length - 1
                                ? 0
                                : defaultMargin,
                          )
                        ],
                      )
                    : Container(),
              ],
            )),
        showTranslation
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultMargin),
                child: SvgPicture.asset(
                  translatedByGoogleSvg,
                ),
              )
            : Container()
      ],
    );
  }
}
