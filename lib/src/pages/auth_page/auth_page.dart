import 'package:flutter/material.dart';
import 'package:freader/src/core/widgets/record_with_info_card/record_with_info_card.dart';
import 'package:freader/src/core/widgets/second_background_empty_app_bar.dart';
import 'package:freader/src/pages/auth_page/auth_page_content.dart';
import 'package:freader/src/theme/system_bars.dart';
import 'package:freader/src/theme/theme.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setUpBarDefaultStyles(Theme.of(context).secondBackgroundColor);

    return RecordWithInfoCard(
      body: Scaffold(
          appBar: const PhantomAppBar(),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: const SafeArea(
            child: AuthPageContent(),
          )),
    );
  }
}
