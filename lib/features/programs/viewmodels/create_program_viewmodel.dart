import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/models/api_exceptions.dart';
import '../models/program_response_dto.dart';
import '../repositories/program_repository.dart';
import 'program_list_viewmodel.dart';

part 'create_program_viewmodel.g.dart';

@riverpod
class CreateProgramViewModel extends _$CreateProgramViewModel {
  @override
  FutureOr<void> build() {}

  Future<ProgramResponseDto?> createProgram(
    String name,
    String? acronym,
  ) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(programRepositoryProvider);
      final newProgram = await repository.createProgram(name, acronym);

      // Refresh the program list to include the newly created program
      ref.read(programListViewModelProvider.notifier).refresh();

      state = const AsyncData(null);
      return newProgram;
    } on ApiException catch (e) {
      state = AsyncError(e, StackTrace.current);
      return null;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }
}
