// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DBController on DBControllerBase, Store {
  late final _$booksAtom =
      Atom(name: 'DBControllerBase.books', context: context);

  @override
  ObservableList<Book> get books {
    _$booksAtom.reportRead();
    return super.books;
  }

  @override
  set books(ObservableList<Book> value) {
    _$booksAtom.reportWrite(value, super.books, () {
      super.books = value;
    });
  }

  late final _$DBControllerBaseActionController =
      ActionController(name: 'DBControllerBase', context: context);

  @override
  void putBook(Book book) {
    final _$actionInfo = _$DBControllerBaseActionController.startAction(
        name: 'DBControllerBase.putBook');
    try {
      return super.putBook(book);
    } finally {
      _$DBControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeBook(Book book) {
    final _$actionInfo = _$DBControllerBaseActionController.startAction(
        name: 'DBControllerBase.removeBook');
    try {
      return super.removeBook(book);
    } finally {
      _$DBControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
books: ${books}
    ''';
  }
}
