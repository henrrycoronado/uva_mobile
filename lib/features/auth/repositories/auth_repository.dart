import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api/i_api_client.dart';
import '../../../core/providers/api_client_provider.dart';
import '../models/auth_response_dto.dart';
import '../models/login_request_dto.dart';
import 'i_auth_repository.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRepository(apiClient);
});

class AuthRepository implements IAuthRepository {
  final IApiClient _apiClient;

  AuthRepository(this._apiClient);

  @override
  Future<AuthResponseDto> login(LoginRequestDto request) async {
    final response = await _apiClient.post(
      '/api/v1/auth/login',
      body: request.toJson(),
    );

    return AuthResponseDto.fromJson(response);
  }
}
