import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../local_storage/preferences/i_preferences_storage.dart';
import '../local_storage/preferences/preferences_storage.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden');
});

final preferencesStorageProvider = Provider<IPreferencesStorage>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return PreferencesStorage(prefs);
});
