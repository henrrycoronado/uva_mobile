import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/enrollment_response_dto.dart';
import '../repositories/enrollment_repository.dart';

part 'enrollment_list_viewmodel.g.dart';

@riverpod
class EnrollmentListViewModel extends _$EnrollmentListViewModel {
  @override
  FutureOr<List<EnrollmentResponseDto>> build(String activityCode) async {
    final repository = ref.read(enrollmentRepositoryProvider);
    return repository.getByActivity(activityCode);
  }

  Future<void> enroll() async {
    final repository = ref.read(enrollmentRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await repository.enroll(activityCode);
      return repository.getByActivity(activityCode);
    });
  }

  Future<void> cancelEnrollment(String enrollmentCode) async {
    final repository = ref.read(enrollmentRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await repository.cancelEnrollment(enrollmentCode);
      return repository.getByActivity(activityCode);
    });
  }
}

