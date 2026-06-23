import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/local_storage/hive/cache_service.dart';
import '../../../core/local_storage/secure/i_secure_storage.dart';
import '../../../core/network/api/i_api_client.dart';
import '../../../core/providers/api_client_provider.dart';
import '../../../core/providers/secure_storage_provider.dart';
import '../models/auth_response_dto.dart';
import '../models/login_request_dto.dart';
import '../models/register_request_dto.dart';
import 'i_auth_repository.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  final cacheService = ref.watch(cacheServiceProvider);
  return AuthRepository(apiClient, secureStorage, cacheService);
});

class AuthRepository implements IAuthRepository {
  final IApiClient _apiClient;
  final ISecureStorage _secureStorage;
  final CacheService _cacheService;

  AuthRepository(this._apiClient, this._secureStorage, this._cacheService);

  @override
  Future<AuthResponseDto> register(RegisterRequestDto request) async {
    final response = await _apiClient.post(
      '/api/v1/auth/register',
      body: request.toJson(),
    );

    return AuthResponseDto.fromJson(response);
  }

  @override
  Future<AuthResponseDto> login(LoginRequestDto request) async {
    final response = await _apiClient.post(
      '/api/v1/auth/login',
      body: request.toJson(),
    );

    return AuthResponseDto.fromJson(response);
  }

  @override
  Future<void> logout() async {
    final refreshToken = await _secureStorage.getRefreshToken();
    if (refreshToken != null && refreshToken.isNotEmpty) {
      try {
        await _apiClient.post(
          '/api/v1/auth/logout',
          body: {'refreshToken': refreshToken},
        );
      } catch (_) {
        // Fallback: Si falla (por ejemplo, red), de todas formas borramos
      }
    }
    await _cacheService.clearAll();
    await _secureStorage.clearAll();
  }

  @override
  Future<AuthResponseDto> refresh() async {
    final refreshToken = await _secureStorage.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      throw Exception('No refresh token available');
    }

    final response = await _apiClient.post(
      '/api/v1/auth/refresh',
      body: {'refreshToken': refreshToken},
    );

    final dto = AuthResponseDto.fromJson(response);

    if (dto.token != null) {
      await _secureStorage.saveToken(dto.token!);
    }
    if (dto.refreshToken != null) {
      await _secureStorage.saveRefreshToken(dto.refreshToken!);
    }

    return dto;
  }
}
