import '../models/auth_response_dto.dart';
import '../models/login_request_dto.dart';

abstract class IAuthRepository {
  Future<AuthResponseDto> login(LoginRequestDto request);
}
