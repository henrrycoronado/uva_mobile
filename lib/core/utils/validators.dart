import 'constants.dart';

class AppValidators {
  AppValidators._();

  static String? validateRequired(
    String? value, {
    String fieldName = 'Este campo',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName es requerido';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El correo es requerido';
    }
    final regex = RegExp(AppConstants.emailRegex);
    if (!regex.hasMatch(value)) {
      return 'Ingresa un correo electrónico válido';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'La contraseña es requerida';
    }
    // El backend pide min 8. Nosotros exigimos además seguridad estándar
    if (value.length < 8) {
      return 'La contraseña debe tener mínimo 8 caracteres';
    }
    final regex = RegExp(AppConstants.passwordRegex);
    if (!regex.hasMatch(value)) {
      return 'Debe tener al menos 1 mayúscula y 1 número';
    }
    return null;
  }

  static String? validateMinLength(
    String? value,
    int min, {
    String fieldName = 'Este campo',
  }) {
    if (value == null || value.trim().length < min) {
      return '$fieldName debe tener al menos $min caracteres';
    }
    return null;
  }

  static String? validateMaxLength(
    String? value,
    int max, {
    String fieldName = 'Este campo',
  }) {
    if (value != null && value.trim().length > max) {
      return '$fieldName no puede exceder $max caracteres';
    }
    return null;
  }

  static String? validateLength(
    String? value,
    int min,
    int max, {
    String fieldName = 'Este campo',
  }) {
    final length = value?.trim().length ?? 0;
    if (length < min || length > max) {
      return '$fieldName debe tener entre $min y $max caracteres';
    }
    return null;
  }
}
