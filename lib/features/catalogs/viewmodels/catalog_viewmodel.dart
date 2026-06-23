import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/catalog_repository.dart';

part 'catalog_viewmodel.g.dart';

@riverpod
class ActivityTypesCatalogViewModel extends _$ActivityTypesCatalogViewModel {
  @override
  FutureOr<List<Map<String, dynamic>>> build() async {
    final repository = ref.read(catalogRepositoryProvider);
    return repository.getActivityTypes();
  }
}
