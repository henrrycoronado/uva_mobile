import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/models/api_exceptions.dart';
import '../models/program_response_dto.dart';
import '../models/update_program_dto.dart';
import '../repositories/program_repository.dart';
import 'program_list_viewmodel.dart';

part 'update_program_viewmodel.g.dart';

@riverpod
class UpdateProgramViewModel extends _$UpdateProgramViewModel {
  @override
  FutureOr<void> build() {}

  Future<ProgramResponseDto?> updateProgram(
    String uvaCode,
    UpdateProgramDto dto,
  ) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(programRepositoryProvider);
      final updatedProgram = await repository.updateProgram(uvaCode, dto);

      // Refresh the program list so the new data reflects on the main screen
      ref.read(programListViewModelProvider.notifier).refresh();

      state = const AsyncData(null);
      return updatedProgram;
    } on ApiException catch (e) {
      state = AsyncError(e, StackTrace.current);
      return null;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }
}
