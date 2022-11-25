// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SetController on SetControllerBase, Store {
  late final _$recordsAtom =
      Atom(name: 'SetControllerBase.records', context: context);

  @override
  List<Record> get records {
    _$recordsAtom.reportRead();
    return super.records;
  }

  @override
  set records(List<Record> value) {
    _$recordsAtom.reportWrite(value, super.records, () {
      super.records = value;
    });
  }

  @override
  String toString() {
    return '''
records: ${records}
    ''';
  }
}
