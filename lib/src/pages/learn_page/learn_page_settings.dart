import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/group_buttons.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
import 'package:group_button/group_button.dart';
import 'package:numberpicker/numberpicker.dart';

class LearnPageSettings extends StatelessWidget {
  const LearnPageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(defaultRadius),
        topRight: Radius.circular(defaultRadius),
      ),
      child: Container(
          color: Theme.of(context).colorScheme.background,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: doubleDefaultMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: defaultMargin,
                ),
                Container(
                  height: 4,
                  width: 30,
                  decoration: BoxDecoration(
                      color:
                          Theme.of(context).paleElementColor.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(
                          Radius.circular(defaultRadius))),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                const SizedBox(
                    width: double.maxFinite,
                    child: Text(
                      "Pack size",
                      style: TextStyle(
                          fontSize: 16,
                          color: paleElement,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: defaultMargin,
                ),
                GroupButton(
                  buttonBuilder: (selected, value, context) => Container(
                    width: (MediaQuery.of(context).size.width -
                                doubleDefaultMargin * 2 +
                                defaultMargin) /
                            4 -
                        defaultMargin,
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultMargin),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultRadius),
                      color: Theme.of(context)
                          .unknownWordColor
                          .withOpacity(selected ? 0.7 : 0.3),
                    ),
                    child: Center(
                        child: Text(
                      value as String,
                      style: const TextStyle(
                          fontSize: 16,
                          color: darkGray,
                          fontWeight: FontWeight.w500,
                          height: 1.5),
                    )),
                  ),
                  onSelected: (value, index, isSelected) {},
                  buttons: ["5", "10", "15", "20", "25", "30"],
                  options: const GroupButtonOptions(
                    runSpacing: defaultMargin,
                    spacing: defaultMargin,
                    groupingType: GroupingType.wrap,
                    mainGroupAlignment: MainGroupAlignment.center,
                    textAlign: TextAlign.center,
                    textPadding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    elevation: 0,
                  ),
                ),
                const SizedBox(
                  height: defaultMargin,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Auto pronouncing",
                      style: Theme.of(context).cardSubtitleStyle,
                    ),
                    SizedBox(
                      width: 40,
                      height: 25,
                      child: Switch(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: true,
                        activeColor:
                            Theme.of(context).unknownWordColor.withOpacity(0.7),
                        onChanged: (bool value) {},
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: defaultMargin,
                ),
                const SizedBox(
                    width: double.maxFinite,
                    child: Text(
                      "Front",
                      style: TextStyle(
                          fontSize: 16,
                          color: paleElement,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: defaultMargin,
                ),
                const GroupButtons(
                  buttonsText: ["Term", "Definition"],
                  states: [false, true],
                ),
                const SizedBox(
                  height: doubleDefaultMargin,
                ),
              ],
            ),
          )),
    );
  }
}
