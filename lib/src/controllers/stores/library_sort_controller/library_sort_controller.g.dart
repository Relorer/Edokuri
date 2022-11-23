// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_sort_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LibrarySortController on LibrarySortControllerBase, Store {
  Computed<String>? _$sortTypeNameComputed;

  @override
  String get sortTypeName =>
      (_$sortTypeNameComputed ??= Computed<String>(() => super.sortTypeName,
              name: 'LibrarySortControllerBase.sortTypeName'))
          .value;

  late final _$sortTypeAtom =
      Atom(name: 'LibrarySortControllerBase.sortType', context: context);

  @override
  BooksSortTypes get sortType {
    _$sortTypeAtom.reportRead();
    return super.sortType;
  }

  @override
  set sortType(BooksSortTypes value) {
    _$sortTypeAtom.reportWrite(value, super.sortType, () {
      super.sortType = value;
    });
  }

  late final _$LibrarySortControllerBaseActionController =
      ActionController(name: 'LibrarySortControllerBase', context: context);

  @override
  void setSortType(BooksSortTypes? type) {
    final _$actionInfo = _$LibrarySortControllerBaseActionController
        .startAction(name: 'LibrarySortControllerBase.setSortType');
    try {
      return super.setSortType(type);
    } finally {
      _$LibrarySortControllerBaseActionController.endAction(_$actionInfo);
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
