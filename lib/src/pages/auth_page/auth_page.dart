import 'package:appwrite/appwrite.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:freader/src/controllers/stores/appwrite/appwrite.dart';
import 'package:freader/src/core/service_locator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freader/src/core/widgets/ellipsis_text.dart';
import 'package:freader/src/core/widgets/record_with_info_card/record_with_info_card.dart';
import 'package:freader/src/core/widgets/second_background_empty_app_bar.dart';
import 'package:freader/src/core/widgets/simple_card.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/library_screen.dart';
import 'package:freader/src/pages/home_page/screens/person_screen/person_screen.dart';
import 'package:freader/src/pages/home_page/screens/records_screen/records_screen.dart';
import 'package:freader/src/theme/svgs.dart';
import 'package:freader/src/theme/system_bars.dart';
import 'package:freader/src/theme/theme.dart';
import 'package:freader/src/theme/theme_consts.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    setUpBarDefaultStyles(Theme.of(context).secondBackgroundColor);

    return RecordWithInfoCard(
      body: Scaffold(
          appBar: PhantomAppBar(),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: Container(
              height: double.maxFinite,
              child: Stack(
                children: [
                  Center(
                    child: Blur(
                      blur: 6,
                      blurColor: Theme.of(context).secondBackgroundColor,
                      child: AutoSizeText(
                        "Unlock the power of language with Edokuri - the innovative foreign book reader designed to boost your vocabulary and enhance your reading experience! With its cutting-edge memory aids, you'll never forget a word or phrase again. Immerse yourself in new worlds and broaden your horizons with Edokuri by your side.",
                        style: const TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.white10),
                      ),
                    ),
                  ),
                  Center(
                      child:
                          Image(image: AssetImage("assets/images/logo.png"))),
                  Padding(
                    padding: const EdgeInsets.all(doubleDefaultMargin * 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SimpleCard(
                          onTap: () => {},
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: doubleDefaultMargin,
                                  vertical: doubleDefaultMargin),
                              child: Row(
                                children: [
                                  Center(
                                    child: SvgPicture.asset(
                                      googleLogoSvg,
                                      height: 30,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: doubleDefaultMargin,
                                  ),
                                  Expanded(
                                    child: EllipsisText(
                                      "Sign in with Google",
                                      style: Theme.of(context).bookTitleStyle,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: doubleDefaultMargin,
                        ),
                        SimpleCard(
                          color: Color(0xFF444444),
                          onTap: () => {},
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: doubleDefaultMargin,
                                  vertical: doubleDefaultMargin),
                              child: Row(
                                children: [
                                  Center(
                                    child: SvgPicture.asset(githubMarkWhiteSvg,
                                        height: 30),
                                  ),
                                  const SizedBox(
                                    width: doubleDefaultMargin,
                                  ),
                                  Expanded(
                                    child: EllipsisText(
                                      "Sign in with GitHub",
                                      style: Theme.of(context)
                                          .bookTitleStyle
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: doubleDefaultMargin,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Skip",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              color: Theme.of(context).secondBackgroundColor,
            ),
          )),
    );
  }
}

//  TextButton(
//                 onPressed: () {
//                   var a = getIt<Appwrite>();
//                   final account = Account(a.client);
//                   account.createOAuth2Session(provider: 'google');
//                 },
//                 child: Text("test"))