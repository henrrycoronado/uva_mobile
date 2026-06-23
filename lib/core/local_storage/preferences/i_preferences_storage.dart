abstract class IPreferencesStorage {
  Future<void> saveThemeMode(String mode);
  String? getThemeMode();
  Future<void> saveTextScale(String scale);
  String? getTextScale();
  Future<void> saveLocale(String languageCode);
  String? getLocale();
}
