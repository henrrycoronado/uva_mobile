import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/home_state.dart';
import '../repositories/home_repository.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  FutureOr<HomeState> build() async {
    return _fetchDashboardData();
  }

  Future<HomeState> _fetchDashboardData({bool forceRefresh = false}) async {
    final repository = ref.read(homeRepositoryProvider);

    final results = await Future.wait([
      repository.getMe(forceRefresh: forceRefresh),
      repository.getMyVolunteerHistory(forceRefresh: forceRefresh),
      repository.getMyScholarships(forceRefresh: forceRefresh),
    ]);

    return HomeState(
      profile: results[0] as dynamic,
      history: results[1] as dynamic,
      scholarships: results[2] as dynamic,
    );
  }

  Future<void> refresh({bool forceRefresh = false}) async {
    if (forceRefresh) {
      state = const AsyncValue.loading();
    }
    state = await AsyncValue.guard(() => _fetchDashboardData(forceRefresh: forceRefresh));
  }
}
