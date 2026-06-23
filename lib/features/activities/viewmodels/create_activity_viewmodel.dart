import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/models/api_exceptions.dart';
import '../models/activity_response_dto.dart';
import '../models/create_activity_simple_dto.dart';
import '../repositories/activity_repository.dart';
import 'activity_list_viewmodel.dart';

part 'create_activity_viewmodel.g.dart';

@riverpod
class CreateActivityViewModel extends _$CreateActivityViewModel {
  @override
  FutureOr<void> build() {}

  Future<ActivityResponseDto?> createActivity(CreateActivitySimpleDto dto) async {
    state = const AsyncLoading();
    
    try {
      final repository = ref.read(activityRepositoryProvider);
      final newActivity = await repository.createSimple(dto);
      
      // Refresh the activities list for the program
      ref.read(activityListViewModelProvider(dto.programCode).notifier).refresh();
      
      state = const AsyncData(null);
      return newActivity;
    } on ApiException catch (e) {
      state = AsyncError(e, StackTrace.current);
      return null;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }
}
