import 'package:shared_preferences/shared_preferences.dart';
import 'i_preferences_storage.dart';

class PreferencesStorage implements IPreferencesStorage {
  final SharedPreferences _prefs;

  const PreferencesStorage(this._prefs);

  static const String _themeKey = 'app_theme_mode';
  static const String _localeKey = 'app_locale';
  static const String _textScaleKey = 'app_text_scale';

  @override
  Future<void> saveThemeMode(String mode) async {
    await _prefs.setString(_themeKey, mode);
  }

  @override
  String? getThemeMode() {
    return _prefs.getString(_themeKey);
  }

  @override
  Future<void> saveTextScale(String scale) async {
    await _prefs.setString(_textScaleKey, scale);
  }

  @override
  String? getTextScale() {
    return _prefs.getString(_textScaleKey);
  }

  @override
  Future<void> saveLocale(String languageCode) async {
    await _prefs.setString(_localeKey, languageCode);
  }

  @override
  String? getLocale() {
    return _prefs.getString(_localeKey);
  }
}
