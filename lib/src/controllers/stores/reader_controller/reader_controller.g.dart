// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReaderController on ReaderControllerBase, Store {
  Computed<int>? _$completedPagesComputed;

  @override
  int get completedPages =>
      (_$completedPagesComputed ??= Computed<int>(() => super.completedPages,
              name: 'ReaderControllerBase.completedPages'))
          .value;

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

  late final _$currentCompletedChapterAtom = Atom(
      name: 'ReaderControllerBase.currentCompletedChapter', context: context);

  @override
  int get currentCompletedChapter {
    _$currentCompletedChapterAtom.reportRead();
    return super.currentCompletedChapter;
  }

  @override
  set currentCompletedChapter(int value) {
    _$currentCompletedChapterAtom
        .reportWrite(value, super.currentCompletedChapter, () {
      super.currentCompletedChapter = value;
    });
  }

  late final _$currentCompletedPageAtom =
      Atom(name: 'ReaderControllerBase.currentCompletedPage', context: context);

  @override
  int get currentCompletedPage {
    _$currentCompletedPageAtom.reportRead();
    return super.currentCompletedPage;
  }

  @override
  set currentCompletedPage(int value) {
    _$currentCompletedPageAtom.reportWrite(value, super.currentCompletedPage,
        () {
      super.currentCompletedPage = value;
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
  Future<dynamic> loadContent(Size pageSize, TextStyle style) {
    return _$loadContentAsyncAction
        .run(() => super.loadContent(pageSize, style));
  }

  late final _$ReaderControllerBaseActionController =
      ActionController(name: 'ReaderControllerBase', context: context);

  @override
  void pageChangedHandler(int index) {
    final _$actionInfo = _$ReaderControllerBaseActionController.startAction(
        name: 'ReaderControllerBase.pageChangedHandler');
    try {
      return super.pageChangedHandler(index);
    } finally {
      _$ReaderControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pageCount: ${pageCount},
currentChapter: ${currentChapter},
currentPage: ${currentPage},
currentCompletedChapter: ${currentCompletedChapter},
currentCompletedPage: ${currentCompletedPage},
chaptersContent: ${chaptersContent},
completedPages: ${completedPages}
    ''';
  }
}
