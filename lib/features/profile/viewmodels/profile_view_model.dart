import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../home/models/profile_response_dto.dart';
import '../repositories/profile_repository.dart';

part 'profile_view_model.g.dart';

@riverpod
class ProfileViewModel extends _$ProfileViewModel {
  @override
  FutureOr<ProfileResponseDto> build() async {
    return _fetchProfile();
  }

  Future<ProfileResponseDto> _fetchProfile({bool forceRefresh = false}) async {
    final repo = ref.read(profileRepositoryProvider);
    return await repo.getMe(forceRefresh: forceRefresh);
  }

  Future<void> refresh({bool forceRefresh = false}) async {
    if (forceRefresh) {
      state = const AsyncValue.loading();
    }
    state = await AsyncValue.guard(() => _fetchProfile(forceRefresh: forceRefresh));
  }
}
