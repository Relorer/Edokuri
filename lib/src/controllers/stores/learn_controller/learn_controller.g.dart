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

  late final _$currentRecordIndexAtom =
      Atom(name: 'LearnControllerBase.currentRecordIndex', context: context);

  @override
  int get currentRecordIndex {
    _$currentRecordIndexAtom.reportRead();
    return super.currentRecordIndex;
  }

  @override
  set currentRecordIndex(int value) {
    _$currentRecordIndexAtom.reportWrite(value, super.currentRecordIndex, () {
      super.currentRecordIndex = value;
    });
  }

  late final _$currentRecordAtom =
      Atom(name: 'LearnControllerBase.currentRecord', context: context);

  @override
  Record get currentRecord {
    _$currentRecordAtom.reportRead();
    return super.currentRecord;
  }

  @override
  set currentRecord(Record value) {
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

  late final _$autoPronouncingAtom =
      Atom(name: 'LearnControllerBase.autoPronouncing', context: context);

  @override
  bool get autoPronouncing {
    _$autoPronouncingAtom.reportRead();
    return super.autoPronouncing;
  }

  @override
  set autoPronouncing(bool value) {
    _$autoPronouncingAtom.reportWrite(value, super.autoPronouncing, () {
      super.autoPronouncing = value;
    });
  }

  late final _$definitionOnAtom =
      Atom(name: 'LearnControllerBase.definitionOn', context: context);

  @override
  bool get definitionOn {
    _$definitionOnAtom.reportRead();
    return super.definitionOn;
  }

  @override
  set definitionOn(bool value) {
    _$definitionOnAtom.reportWrite(value, super.definitionOn, () {
      super.definitionOn = value;
    });
  }

  late final _$termOnAtom =
      Atom(name: 'LearnControllerBase.termOn', context: context);

  @override
  bool get termOn {
    _$termOnAtom.reportRead();
    return super.termOn;
  }

  @override
  set termOn(bool value) {
    _$termOnAtom.reportWrite(value, super.termOn, () {
      super.termOn = value;
    });
  }

  late final _$LearnControllerBaseActionController =
      ActionController(name: 'LearnControllerBase', context: context);

  @override
  void setCurrentRecord(Record record) {
    final _$actionInfo = _$LearnControllerBaseActionController.startAction(
        name: 'LearnControllerBase.setCurrentRecord');
    try {
      return super.setCurrentRecord(record);
    } finally {
      _$LearnControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBunchSize(int size) {
    final _$actionInfo = _$LearnControllerBaseActionController.startAction(
        name: 'LearnControllerBase.setBunchSize');
    try {
      return super.setBunchSize(size);
    } finally {
      _$LearnControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAutoPronouncing(bool value) {
    final _$actionInfo = _$LearnControllerBaseActionController.startAction(
        name: 'LearnControllerBase.setAutoPronouncing');
    try {
      return super.setAutoPronouncing(value);
    } finally {
      _$LearnControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDefinitionOn(bool value) {
    final _$actionInfo = _$LearnControllerBaseActionController.startAction(
        name: 'LearnControllerBase.setDefinitionOn');
    try {
      return super.setDefinitionOn(value);
    } finally {
      _$LearnControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTermOn(bool value) {
    final _$actionInfo = _$LearnControllerBaseActionController.startAction(
        name: 'LearnControllerBase.setTermOn');
    try {
      return super.setTermOn(value);
    } finally {
      _$LearnControllerBaseActionController.endAction(_$actionInfo);
    }
  }

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
currentRecordIndex: ${currentRecordIndex},
currentRecord: ${currentRecord},
bunchSize: ${bunchSize},
autoPronouncing: ${autoPronouncing},
definitionOn: ${definitionOn},
termOn: ${termOn},
total: ${total}
    ''';
  }
}
