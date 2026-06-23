import '../../../l10n/app_localizations.dart';
import 'constants.dart';

class AppValidators {
  AppValidators._();

  static String? validateRequired(
    String? value,
    AppLocalizations l10n, {
    String fieldName = '',
  }) {
    if (value == null || value.trim().isEmpty) {
      return l10n.fieldRequired(fieldName);
    }
    return null;
  }

  static String? validateEmail(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.emailRequired;
    }
    final regex = RegExp(AppConstants.emailRegex);
    if (!regex.hasMatch(value)) {
      return l10n.invalidEmail;
    }
    return null;
  }

  static String? validatePassword(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.passwordRequired;
    }
    if (value.length < 8) {
      return l10n.passwordMinLength;
    }
    final regex = RegExp(AppConstants.passwordRegex);
    if (!regex.hasMatch(value)) {
      return l10n.passwordFormat;
    }
    return null;
  }

  static String? validateMatch(
    String? value,
    String? match,
    AppLocalizations l10n,
  ) {
    if (value != match) {
      return l10n.passwordsDoNotMatch;
    }
    return null;
  }

  static String? validateMinLength(
    String? value,
    AppLocalizations l10n,
    int min, {
    String fieldName = '',
  }) {
    if (value == null || value.trim().length < min) {
      return l10n.minLength(fieldName, min);
    }
    return null;
  }

  static String? validateMaxLength(
    String? value,
    AppLocalizations l10n,
    int max, {
    String fieldName = '',
  }) {
    if (value != null && value.trim().length > max) {
      return l10n.maxLength(fieldName, max);
    }
    return null;
  }

  static String? validateLength(
    String? value,
    AppLocalizations l10n,
    int min,
    int max, {
    String fieldName = '',
  }) {
    final length = value?.trim().length ?? 0;
    if (length < min || length > max) {
      return l10n.lengthRange(fieldName, min, max);
    }
    return null;
  }
}
