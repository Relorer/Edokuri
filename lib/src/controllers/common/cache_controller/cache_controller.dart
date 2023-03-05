import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheController {
  final DefaultCacheManager _manager = DefaultCacheManager();

  CacheController();

  Future<File> putFile(List<int> bytes, String id) async {
    return _manager.putFile(id, Uint8List.fromList(bytes),
        maxAge: const Duration(days: 0x7fffffff));
  }

  Future<List<int>?> getFile(InputFile file, String id) async {
    final fileInfo = await _manager.getFileFromCache(id);
    return fileInfo?.file.readAsBytes();
  }

  Future<void> removeFile(String id) {
    return _manager.removeFile(id);
  }
}
