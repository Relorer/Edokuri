// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_repository.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BookRepository on BookRepositoryBase, Store {
  late final _$BookRepositoryBaseActionController =
      ActionController(name: 'BookRepositoryBase', context: context);

  @override
  void setNewList(List<Book> newBooks) {
    final _$actionInfo = _$BookRepositoryBaseActionController.startAction(
        name: 'BookRepositoryBase.setNewList');
    try {
      return super.setNewList(newBooks);
    } finally {
      _$BookRepositoryBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
