import 'dart:convert';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache_service.g.dart';

class CacheService {
  static const String _boxName = 'app_cache';
  late Box _box;

  Future<void> init() async {
    _box = await Hive.openBox(_boxName);
  }

  /// Guards against returning expired cache unless fallback is needed.
  /// If [maxAge] is provided, checks if the cache is older than the max age.
  /// If it is expired and [ignoreExpiration] is false, it returns null.
  /// If [ignoreExpiration] is true, it returns the cache anyway (Fallback mode).
  Future<dynamic> get(
    String key, {
    Duration? maxAge,
    bool ignoreExpiration = false,
  }) async {
    final entry = _box.get(key);
    if (entry == null) return null;

    try {
      final map = jsonDecode(entry) as Map<String, dynamic>;
      final timestamp = map['timestamp'] as int?;
      final data = map['data'];

      if (timestamp != null && maxAge != null && !ignoreExpiration) {
        final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
        final age = DateTime.now().difference(cacheTime);
        if (age > maxAge) {
          return null; // Expired
        }
      }
      return data;
    } catch (e) {
      return null; // Malformed cache
    }
  }

  /// Saves any JSON-serializable [data] with a current timestamp.
  Future<void> set(String key, dynamic data) async {
    final entry = {
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'data': data,
    };
    await _box.put(key, jsonEncode(entry));
  }

  /// Clears all data from the cache.
  Future<void> clearAll() async {
    await _box.clear();
  }
}

@riverpod
CacheService cacheService(Ref ref) {
  throw UnimplementedError('cacheServiceProvider not initialized');
}
