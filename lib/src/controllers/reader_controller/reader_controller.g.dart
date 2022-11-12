// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReaderController on ReaderControllerBase, Store {
  late final _$currentChapterAtom =
      Atom(name: 'ReaderControllerBase.currentChapter', context: context);

  @override
  int get currentChapter {
    _$currentChapterAtom.reportRead();
    return super.currentChapter;
  }

  @override
  set currentChapter(int value) {
    _$currentChapterAtom.reportWrite(value, super.currentChapter, () {
      super.currentChapter = value;
    });
  }

  late final _$pageCountAtom =
      Atom(name: 'ReaderControllerBase.pageCount', context: context);

  @override
  int get pageCount {
    _$pageCountAtom.reportRead();
    return super.pageCount;
  }

  @override
  set pageCount(int value) {
    _$pageCountAtom.reportWrite(value, super.pageCount, () {
      super.pageCount = value;
    });
  }

  late final _$currentPageAtom =
      Atom(name: 'ReaderControllerBase.currentPage', context: context);

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$completedPagesAtom =
      Atom(name: 'ReaderControllerBase.completedPages', context: context);

  @override
  int get completedPages {
    _$completedPagesAtom.reportRead();
    return super.completedPages;
  }

  @override
  set completedPages(int value) {
    _$completedPagesAtom.reportWrite(value, super.completedPages, () {
      super.completedPages = value;
    });
  }

  late final _$chaptersContentAtom =
      Atom(name: 'ReaderControllerBase.chaptersContent', context: context);

  @override
  List<List<String>> get chaptersContent {
    _$chaptersContentAtom.reportRead();
    return super.chaptersContent;
  }

  @override
  set chaptersContent(List<List<String>> value) {
    _$chaptersContentAtom.reportWrite(value, super.chaptersContent, () {
      super.chaptersContent = value;
    });
  }

  late final _$loadContentAsyncAction =
      AsyncAction('ReaderControllerBase.loadContent', context: context);

  @override
  Future<dynamic> loadContent(Book book, Size pageSize) {
    return _$loadContentAsyncAction
        .run(() => super.loadContent(book, pageSize));
  }

  late final _$ReaderControllerBaseActionController =
      ActionController(name: 'ReaderControllerBase', context: context);

  @override
  void _updatePosition(List<String> chapter, int index, int sumPages) {
    final _$actionInfo = _$ReaderControllerBaseActionController.startAction(
        name: 'ReaderControllerBase._updatePosition');
    try {
      return super._updatePosition(chapter, index, sumPages);
    } finally {
      _$ReaderControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentChapter: ${currentChapter},
pageCount: ${pageCount},
currentPage: ${currentPage},
completedPages: ${completedPages},
chaptersContent: ${chaptersContent}
    ''';
  }
}
