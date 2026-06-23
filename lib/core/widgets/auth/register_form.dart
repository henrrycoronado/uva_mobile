import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/utils/validators.dart';
import '../../../l10n/app_localizations.dart';
import '../common/custom_button.dart';
import '../common/custom_text_field.dart';

class RegisterForm extends StatefulWidget {
  final bool isLoading;
  final void Function(String firstName, String lastName, String email, String password) onRegister;

  const RegisterForm({
    super.key,
    this.isLoading = false,
    required this.onRegister,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onRegister(
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        padding: const EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.register,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                controller: _firstNameController,
                label: l10n.firstNameLabel,
                validator: (v) => AppValidators.validateLength(
                  v,
                  l10n,
                  2,
                  100,
                  fieldName: l10n.firstNameLabel,
                ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _lastNameController,
                label: l10n.lastNameLabel,
                validator: (v) => AppValidators.validateLength(
                  v,
                  l10n,
                  2,
                  100,
                  fieldName: l10n.lastNameLabel,
                ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _emailController,
                label: l10n.emailLabel,
                validator: (v) => AppValidators.validateEmail(v, l10n),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                label: l10n.passwordLabel,
                obscureText: true,
                validator: (v) => AppValidators.validatePassword(v, l10n),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _confirmPasswordController,
                label: l10n.confirmPasswordLabel,
                obscureText: true,
                validator: (v) => AppValidators.validateMatch(
                  v,
                  _passwordController.text,
                  l10n,
                ),
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: l10n.register,
                isLoading: widget.isLoading,
                onPressed: _onRegisterPressed,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go(AppRoutes.login);
                  }
                },
                child: Text(l10n.alreadyHaveAccount),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

