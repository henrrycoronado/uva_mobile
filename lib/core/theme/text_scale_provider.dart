import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/preferences_provider.dart';

class TextScaleNotifier extends Notifier<double> {
  @override
  double build() {
    final prefs = ref.watch(preferencesStorageProvider);
    final savedScale = prefs.getTextScale();

    if (savedScale == 'small') return 0.85;
    if (savedScale == 'large') return 1.15;
    return 1.0;
  }

  Future<void> changeScale(String scaleName) async {
    final prefs = ref.read(preferencesStorageProvider);

    double newScale = 1.0;
    if (scaleName == 'small') newScale = 0.85;
    if (scaleName == 'large') newScale = 1.15;

    await prefs.saveTextScale(scaleName);
    state = newScale;
  }
}

final textScaleProvider = NotifierProvider<TextScaleNotifier, double>(() {
  return TextScaleNotifier();
});
