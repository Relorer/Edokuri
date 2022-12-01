// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learn_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LearnController on LearnControllerBase, Store {
  Computed<int>? _$totalComputed;

  @override
  int get total => (_$totalComputed ??=
          Computed<int>(() => super.total, name: 'LearnControllerBase.total'))
      .value;

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

  late final _$bunchSizeAtom =
      Atom(name: 'LearnControllerBase.bunchSize', context: context);

  @override
  int get bunchSize {
    _$bunchSizeAtom.reportRead();
    return super.bunchSize;
  }

  @override
  set bunchSize(int value) {
    _$bunchSizeAtom.reportWrite(value, super.bunchSize, () {
      super.bunchSize = value;
    });
  }

  late final _$LearnControllerBaseActionController =
      ActionController(name: 'LearnControllerBase', context: context);

  @override
  void answerHandler(int index, bool know) {
    final _$actionInfo = _$LearnControllerBaseActionController.startAction(
        name: 'LearnControllerBase.answerHandler');
    try {
      return super.answerHandler(index, know);
    } finally {
      _$LearnControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentRecord: ${currentRecord},
bunchSize: ${bunchSize},
total: ${total}
    ''';
  }
}
