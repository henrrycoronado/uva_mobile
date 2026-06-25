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

  Future<HomeState> _fetchDashboardData({
    bool forceRefresh = false,
    int? year,
    int? month,
  }) async {
    final repository = ref.read(homeRepositoryProvider);
    final targetYear = year ?? DateTime.now().year;
    final targetMonth = month ?? DateTime.now().month;

    final results = await Future.wait([
      repository.getMe(forceRefresh: forceRefresh),
      repository.getHomeSummary(
        forceRefresh: forceRefresh,
        year: targetYear,
        month: targetMonth,
      ),
      repository.getMyScholarships(forceRefresh: forceRefresh),
    ]);

    return HomeState(
      profile: results[0] as dynamic,
      summary: results[1] as dynamic,
      scholarships: results[2] as dynamic,
      currentYear: targetYear,
      currentMonth: targetMonth,
    );
  }

  Future<void> refresh({bool forceRefresh = false}) async {
    final currentState = state.value;
    final year = currentState?.currentYear;
    final month = currentState?.currentMonth;

    if (forceRefresh) {
      state = const AsyncValue.loading();
    }
    state = await AsyncValue.guard(
      () => _fetchDashboardData(
        forceRefresh: forceRefresh,
        year: year,
        month: month,
      ),
    );
  }

  Future<void> changeMonth(int month, int year) async {
    final currentState = state.value;
    if (currentState == null) return;

    // Optimistic update for UI feel (optional) or just loading
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(homeRepositoryProvider);
      final newSummary = await repository.getHomeSummary(
        forceRefresh: true, // Fetch fresh data for the new month
        year: year,
        month: month,
      );

      return currentState.copyWith(
        summary: newSummary,
        currentMonth: month,
        currentYear: year,
      );
    });
  }
}
