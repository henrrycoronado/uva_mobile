import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api/i_api_client.dart';
import '../../../core/providers/api_client_provider.dart';
import '../models/enrollment_response_dto.dart';

final enrollmentRepositoryProvider = Provider<EnrollmentRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return EnrollmentRepository(apiClient);
});

class EnrollmentRepository {
  final IApiClient _apiClient;

  EnrollmentRepository(this._apiClient);

  Future<List<EnrollmentResponseDto>> getByActivity(String activityCode) async {
    final response = await _apiClient.get('/api/v1/enrollments/by-activity/$activityCode');
    final data = response as List;
    return data.map((e) => EnrollmentResponseDto.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<EnrollmentResponseDto> enroll(String activityCode) async {
    final response = await _apiClient.post(
      '/api/v1/enrollments',
      body: {'activityCode': activityCode},
    );
    return EnrollmentResponseDto.fromJson(response as Map<String, dynamic>);
  }

  Future<void> cancelEnrollment(String enrollmentCode) async {
    await _apiClient.patch('/api/v1/enrollments/$enrollmentCode/cancel');
  }
}

