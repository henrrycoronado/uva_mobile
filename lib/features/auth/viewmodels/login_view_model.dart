import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/models/api_exceptions.dart';
import '../../../core/providers/secure_storage_provider.dart';
import '../models/login_request_dto.dart';
import '../repositories/auth_repository.dart';

class LoginViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(authRepositoryProvider);
      final secureStorage = ref.read(secureStorageProvider);

      final request = LoginRequestDto(email: email, password: password);
      final response = await repository.login(request);

      if (response.token != null) {
        await secureStorage.saveToken(response.token!);
      }

      state = const AsyncData(null);
    } on ApiException catch (e) {
      state = AsyncError(e, StackTrace.current);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final loginViewModelProvider = AsyncNotifierProvider<LoginViewModel, void>(() {
  return LoginViewModel();
});
