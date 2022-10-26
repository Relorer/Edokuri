import 'package:flutter/material.dart';
import 'package:freader/Services/file_picker_service.dart';
import 'package:freader/pages/reader_page.dart';
import '../Services/epub_service.dart';
import '../models/book.dart';
import '../objectbox.g.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EpubService epubService = EpubService();
  final FilePickerService filePickerService = FilePickerService();

  late Stream<List<Book>> _stream;

  late Store _store;

  @override
  void initState() {
    super.initState();
    _store = openStore();
    _stream = _store
        .box<Book>()
        .query()
        .watch(triggerImmediately: true)
        .map((query) => query.find());
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
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.amberAccent,
        child: Column(
          children: <Widget>[
            TextButton(
              onPressed: _addButtonHandler,
              child: const Text("Add"),
            ),
            StreamBuilder<List<Book>>(
              stream: _stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    children: snapshot.data
                            ?.map((e) => GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ReaderPage(book: e),
                                      ),
                                    );
                                  },
                                  child: Text(e.title),
                                ))
                            .toList() ??
                        [],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
