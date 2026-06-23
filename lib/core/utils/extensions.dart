import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String capitalizeWords() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }
}

enum SnackBarType { info, success, warning, error }

extension BuildContextExtension on BuildContext {
  void showSnackBar(
    String message, {
    bool isError = false,
    SnackBarType? type,
  }) {
    // Resolve color
    Color bgColor = AppColors.info;

    if (isError) {
      bgColor = AppColors.error;
    } else if (type != null) {
      switch (type) {
        case SnackBarType.info:
          bgColor = AppColors.info;
          break;
        case SnackBarType.success:
          bgColor = AppColors.success;
          break;
        case SnackBarType.warning:
          bgColor = AppColors.warning;
          break;
        case SnackBarType.error:
          bgColor = AppColors.error;
          break;
      }
    }

    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: bgColor,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;
}
