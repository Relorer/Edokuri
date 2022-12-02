import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/group_buttons.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';
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
                DirectSelect(
                    itemExtent: 35.0,
                    selectedIndex: 1,
                    child: Text("test"),
                    onSelectedItemChanged: (index) {},
                    items: [5, 10, 15].map((e) => Text(e.toString())).toList()),
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
                  height: doubleDefaultMargin,
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
