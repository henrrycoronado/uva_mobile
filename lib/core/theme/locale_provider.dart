import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/preferences_provider.dart';

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    final prefs = ref.watch(preferencesStorageProvider);
    final savedLocale = prefs.getLocale();

    if (savedLocale != null) {
      return Locale(savedLocale);
    }

    final systemLocale = Platform.localeName.split('_').first;
    if (systemLocale == 'en') return const Locale('en');

    return const Locale('es');
  }

  Future<void> changeLocale(String languageCode) async {
    final prefs = ref.read(preferencesStorageProvider);
    await prefs.saveLocale(languageCode);
    state = Locale(languageCode);
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(() {
  return LocaleNotifier();
});
