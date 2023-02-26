import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/bouncing_custom_scroll_view.dart';
import 'package:freader/src/core/widgets/sliver_single_child.dart';
import 'package:freader/src/pages/auth_page/auth_page_blur_text_bg.dart';
import 'package:freader/src/pages/auth_page/auth_page_login_buttons.dart';
import 'package:freader/src/pages/auth_page/auth_page_logo.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class AuthPageContent extends StatelessWidget {
  const AuthPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: Theme.of(context).secondBackgroundColor,
      child: Stack(
        children: [
          const AuthPageBlurTextBg(),
          BouncingCustomScrollView(
            revers: true,
            slivers: [
              SliverSingleChild(Column(
                children: const [
                  AuthPageLogo(),
                  Padding(
                      padding: EdgeInsets.all(doubleDefaultMargin * 2),
                      child: AuthPageLoginButtons())
                ],
              ))
            ],
          )
        ],
      ),
    );
  }
}
