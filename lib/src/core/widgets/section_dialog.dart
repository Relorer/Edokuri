// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:edokuri/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:edokuri/src/core/widgets/second_background_empty_app_bar.dart';
import 'package:edokuri/src/core/widgets/sliver_single_child.dart';
import 'package:edokuri/src/theme/theme.dart';
import 'package:edokuri/src/theme/theme_consts.dart';

class SectionDialog extends StatelessWidget {
  final List<Widget> children;

  const SectionDialog(this.children, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PhantomAppBar(),
      body: SafeArea(
          child: Container(
        color: Theme.of(context).secondBackgroundColor,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: BouncingCustomScrollView(
            revers: true,
            slivers: [
              SliverSingleChild(Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...children,
                  const SizedBox(
                    height: doubleDefaultMargin,
                  ),
                  SizedBox(
                      width: double.maxFinite,
                      child: Material(
                        color: Theme.of(context).secondBackgroundColor,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Padding(
                            padding: const EdgeInsets.all(doubleDefaultMargin),
                            child: Text(
                              'Cancel',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).dialogTextStyleBright,
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: doubleDefaultMargin,
                  )
                ],
              ))
            ],
          ),
        ),
      )),
    );
  }
}
