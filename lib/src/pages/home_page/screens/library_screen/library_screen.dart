import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freader/src/controllers/db_controller/provider_db_controller.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/alert_dialog_widget.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/book_card_widget.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/graph_widget.dart';
import 'package:freader/src/pages/home_page/screens/library_screen/widgets/title_widget.dart';
import 'package:freader/src/pages/home_page/widget/content_container_widget.dart';
import 'package:freader/src/pages/home_page/widget/header_container_widget.dart';
import 'package:freader/src/pages/home_page/widget/sector_title_widget.dart';
import 'package:freader/src/theme/theme.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).secondBackgroundColor,
      statusBarColor: Theme.of(context).secondBackgroundColor,
      statusBarIconBrightness: Brightness.light,
    ));

    double appBarHeight =
        min((MediaQuery.of(context).size.height - 110) * .3, 300);
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
          physics: const BouncingScrollPhysics()),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            titleSpacing: 0,
            expandedHeight: appBarHeight,
            floating: true,
            pinned: true,
            elevation: 0,
            flexibleSpace: SingleChildScrollView(
              child: SizedBox(
                height: appBarHeight,
                child: const HeaderContainerWidget(children: [
                  TitleWidget(
                    leftText: "today",
                    rightText: "47m",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GraphWidget(),
                ]),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: SectorTitleWidget(
                          leftText: "Library",
                          onPressed: () {
                            showDialog(
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialogWidget();
                              },
                            );
                          },
                        ),
                      ),
                  childCount: 1)),
          Observer(builder: (_) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: BookCardWidget(
                          book: ProviderDbController.ctr(context).books[index],
                        ),
                      ),
                  childCount: ProviderDbController.ctr(context).books.length),
            );
          })
        ],
      ),
    );
  }
}
