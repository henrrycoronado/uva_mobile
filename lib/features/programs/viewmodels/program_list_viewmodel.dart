import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/program_response_dto.dart';
import '../repositories/program_repository.dart';

part 'program_list_viewmodel.g.dart';

@riverpod
class ProgramSearchQuery extends _$ProgramSearchQuery {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }
}

@riverpod
class ProgramListViewModel extends _$ProgramListViewModel {
  @override
  FutureOr<List<ProgramResponseDto>> build() async {
    return _fetchPrograms();
  }

  Future<List<ProgramResponseDto>> _fetchPrograms({
    bool forceRefresh = false,
  }) async {
    final repository = ref.read(programRepositoryProvider);
    return repository.getPrograms(forceRefresh: forceRefresh);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchPrograms(forceRefresh: true));
  }
}
