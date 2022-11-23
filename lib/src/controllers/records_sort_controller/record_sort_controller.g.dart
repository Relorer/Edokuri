// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_sort_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RecordsSortController on RecordsSortControllerBase, Store {
  Computed<String>? _$sortTypeNameComputed;

  @override
  String get sortTypeName =>
      (_$sortTypeNameComputed ??= Computed<String>(() => super.sortTypeName,
              name: 'RecordsSortControllerBase.sortTypeName'))
          .value;

  late final _$sortTypeAtom =
      Atom(name: 'RecordsSortControllerBase.sortType', context: context);

  @override
  RecordsSortTypes get sortType {
    _$sortTypeAtom.reportRead();
    return super.sortType;
  }

  @override
  set sortType(RecordsSortTypes value) {
    _$sortTypeAtom.reportWrite(value, super.sortType, () {
      super.sortType = value;
    });
  }

  late final _$RecordsSortControllerBaseActionController =
      ActionController(name: 'RecordsSortControllerBase', context: context);

  @override
  void setSortType(RecordsSortTypes? type) {
    final _$actionInfo = _$RecordsSortControllerBaseActionController
        .startAction(name: 'RecordsSortControllerBase.setSortType');
    try {
      return super.setSortType(type);
    } finally {
      _$RecordsSortControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
sortType: ${sortType},
sortTypeName: ${sortTypeName}
    ''';
  }
}
