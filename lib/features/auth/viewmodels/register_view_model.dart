import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/models/api_exceptions.dart';
import '../../../core/providers/secure_storage_provider.dart';
import '../models/register_request_dto.dart';
import '../repositories/auth_repository.dart';

class RegisterViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> register(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(authRepositoryProvider);
      final secureStorage = ref.read(secureStorageProvider);

      final request = RegisterRequestDto(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );

      final response = await repository.register(request);

      if (response.token != null) {
        await secureStorage.saveToken(response.token!);
      }
      if (response.refreshToken != null) {
        await secureStorage.saveRefreshToken(response.refreshToken!);
      }

      state = const AsyncData(null);
    } on ApiException catch (e) {
      state = AsyncError(e, StackTrace.current);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final registerViewModelProvider =
    AsyncNotifierProvider<RegisterViewModel, void>(() {
      return RegisterViewModel();
    });
