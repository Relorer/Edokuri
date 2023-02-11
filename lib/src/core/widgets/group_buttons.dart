import 'package:flutter/material.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class GroupButtons extends StatelessWidget {
  final List<String> buttonsText;
  final List<bool> states;

  final Function(int, bool)? onSelected;

  const GroupButtons(
      {super.key,
      required this.buttonsText,
      required this.states,
      this.onSelected});

  @override
  Widget build(BuildContext context) {
    final List<Widget> buttons = [];

    for (var i = 0; i < buttonsText.length * 2 - 1; i++) {
      if (i % 2 == 0) {
        final index = i ~/ 2;
        buttons.add(Expanded(
            child: _ButtonOfGroupButtons(
          buttonsText[index],
          states[index],
          onSelected: (p0) => onSelected?.call(index, p0),
        )));
      } else {
        buttons.add(const SizedBox(
          width: defaultMargin,
        ));
      }
    }

    return Material(
      color: Colors.transparent,
      child: Row(
        children: buttons,
      ),
    );
  }
}

class _ButtonOfGroupButtons extends StatelessWidget {
  final bool isSelected;
  final String text;
  final Function(bool)? onSelected;

  const _ButtonOfGroupButtons(this.text, this.isSelected,
      {super.key, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius / 2),
      ),
      onTap: () => {onSelected?.call(!isSelected)},
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context)
              .unknownWordColor
              .withOpacity(isSelected ? 0.7 : 0.3),
          borderRadius:
              const BorderRadius.all(Radius.circular(defaultRadius / 2)),
        ),
        padding: const EdgeInsets.all(defaultMargin),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
              fontSize: 16,
              color: darkGray,
              fontWeight: FontWeight.w500,
              height: 1.5),
        )),
      ),
    );
  }
}
