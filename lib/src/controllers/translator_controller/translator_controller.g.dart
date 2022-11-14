// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translator_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TranslatorController on TranslatorControllerBase, Store {
  late final _$pageCountAtom =
      Atom(name: 'TranslatorControllerBase.pageCount', context: context);

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

  @override
  String toString() {
    return '''
pageCount: ${pageCount}
    ''';
  }
}
