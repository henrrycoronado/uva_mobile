import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/models/api_exceptions.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/auth/login_form.dart';
import '../../../l10n/app_localizations.dart';
import '../viewmodels/login_view_model.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final authState = ref.watch(loginViewModelProvider);

    ref.listen<AsyncValue<void>>(loginViewModelProvider, (_, state) {
      state.whenOrNull(
        error: (error, stackTrace) {
          String errorMessage = l10n.genericError;
          if (error is ApiException) {
            errorMessage =
                error.problemDetails?.detail ??
                error.problemDetails?.title ??
                error.message;
            if (errorMessage == 'invalidResponse') {
              errorMessage = l10n.invalidResponse;
            } else if (errorMessage == 'httpError') {
              errorMessage = l10n.httpError(error.statusCode);
            }
          }
          context.showSnackBar(errorMessage, isError: true);
        },
        data: (_) {
          context.go(AppRoutes.home);
        },
      );
    });

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/Logo2.svg', height: 120),
                const SizedBox(height: 48),
                LoginForm(
                  isLoading: authState.isLoading,
                  onLogin: (email, password) {
                    ref
                        .read(loginViewModelProvider.notifier)
                        .login(email, password);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
