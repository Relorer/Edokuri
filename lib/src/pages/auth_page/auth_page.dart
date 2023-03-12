// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:edokuri/src/core/widgets/second_background_empty_app_bar.dart';
import 'package:edokuri/src/pages/auth_page/auth_page_content.dart';
import 'package:edokuri/src/theme/theme.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          systemNavigationBarColor: Theme.of(context).secondBackgroundColor),
      child: Scaffold(
          appBar: const PhantomAppBar(),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: const SafeArea(
            child: AuthPageContent(),
          )),
    );
  }
}
