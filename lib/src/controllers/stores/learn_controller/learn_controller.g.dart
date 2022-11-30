// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learn_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LearnController on LearnControllerBase, Store {
  late final _$currentRecordAtom =
      Atom(name: 'LearnControllerBase.currentRecord', context: context);

  @override
  int get currentRecord {
    _$currentRecordAtom.reportRead();
    return super.currentRecord;
  }

  @override
  set currentRecord(int value) {
    _$currentRecordAtom.reportWrite(value, super.currentRecord, () {
      super.currentRecord = value;
    });
  }

  @override
  String toString() {
    return '''
currentRecord: ${currentRecord}
    ''';
  }
}
