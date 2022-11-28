// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> en = {
    "close": "Close",
    "amount_of_new_words": "Amount of new words",
    "name": "Name",
    "progress": "Progress",
    "recent": "Recent",
    "no_author": "no author",
    "no_title": "no title",
    "records": "Records: {count}",
    "new_words": "{persent}% New words",
    "cover": "cover",
    "continue_reading": "Continue reading",
    "go_to_set": "Go to Set",
    "delete": "Delete",
    "upload_new_book": "Upload new book",
    "sort_by": "Sort by:",
    "today": "today",
    "short_min": "{count}m",
    "library": "Library",
    "part_of": "Part {currentPart} of {partCount}"
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {"en": en};
}
