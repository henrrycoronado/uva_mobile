import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/activity_response_dto.dart';
import '../repositories/activity_repository.dart';

part 'activity_list_viewmodel.g.dart';

@riverpod
class ActivityListViewModel extends _$ActivityListViewModel {
  @override
  FutureOr<List<ActivityResponseDto>> build(String programCode) async {
    final repository = ref.read(activityRepositoryProvider);
    return repository.getActivitiesByProgram(programCode);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => await build(programCode));
  }
}
