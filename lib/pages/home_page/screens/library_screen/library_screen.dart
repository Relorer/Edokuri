import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:freader/Services/epub_service.dart';
import 'package:freader/Services/file_picker_service.dart';
import 'package:freader/pages/home_page/screens/library_screen/widgets/book_card_widget.dart';
import 'package:freader/pages/home_page/screens/library_screen/widgets/graph_widget.dart';
import 'package:freader/pages/home_page/widget/content_container_widget.dart';
import 'package:freader/pages/home_page/widget/header_container_widget.dart';
import 'package:freader/pages/home_page/screens/library_screen/widgets/title_widget.dart';
import 'package:freader/pages/home_page/widget/sector_title_widget.dart';
import 'package:freader/pages/reader/reader_page.dart';
import 'package:freader/theme.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../models/book.dart';
import '../../../../objectbox.g.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  bool init = false;

  late Stream<List<Book>> _stream;

  late Store _store;

  final EpubService epubService = EpubService();
  final FilePickerService filePickerService = FilePickerService();
  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((dir) {
      _store = Store(getObjectBoxModel(), directory: "${dir.path}/objectbox3");
      _stream = _store
          .box<Book>()
          .query()
          .watch(triggerImmediately: true)
          .map((query) => query.find());
      setState(() {
        init = true;
      });
    });
  }

  @override
  void dispose() {
    _store.close();
    super.dispose();
  }

  _addButtonHandler() async {
    var files = await filePickerService.getFiles(allowedExtensions: ["epub"]);
    for (var file in files) {
      var book = await epubService.readBook(file);
      _store.box<Book>().put(book);
    }
  }

  @override
  Widget build(BuildContext context) {
    var appBar = (MediaQuery.of(context).size.height - 110) * .4;
    return init
        ? ScrollConfiguration(
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
                  expandedHeight: appBar,
                  floating: true,
                  pinned: true,
                  elevation: 0,
                  flexibleSpace: SingleChildScrollView(
                    child: SizedBox(
                      height: appBar,
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
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: ContentContainerWidget(children: [
                    SectorTitleWidget(
                      leftText: "Library",
                      onPressed: () {
                        _addButtonHandler();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    StreamBuilder<List<Book>>(
                      stream: _stream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Column(
                            children: snapshot.data
                                    ?.map((e) => BookCardWidget(book: e))
                                    .toList() ??
                                [],
                          );
                        }
                      },
                    )
                  ]),
                )
              ],
            ),
          )
        : Container();
  }
}
