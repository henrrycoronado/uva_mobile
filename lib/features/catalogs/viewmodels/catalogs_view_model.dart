import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/catalog_groups.dart';
import '../models/catalog_item_dto.dart';
import '../repositories/catalogs_repository.dart';

part 'catalogs_view_model.g.dart';

class CatalogsState {
  final Map<String, List<CatalogItemDto>> cachedTypes;
  final Map<String, List<CatalogItemDto>> cachedStates;
  final bool isLoading;

  CatalogsState({
    this.cachedTypes = const {},
    this.cachedStates = const {},
    this.isLoading = false,
  });

  CatalogsState copyWith({
    Map<String, List<CatalogItemDto>>? cachedTypes,
    Map<String, List<CatalogItemDto>>? cachedStates,
    bool? isLoading,
  }) {
    return CatalogsState(
      cachedTypes: cachedTypes ?? this.cachedTypes,
      cachedStates: cachedStates ?? this.cachedStates,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

@Riverpod(keepAlive: true)
class CatalogsViewModel extends _$CatalogsViewModel {
  @override
  CatalogsState build() {
    // Optionally fetch default important catalogs in background
    Future.microtask(() => fetchTypeCatalog(CatalogTypeGroup.career));
    return CatalogsState();
  }

  Future<void> fetchTypeCatalog(
    String groupName, {
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh && state.cachedTypes.containsKey(groupName)) return;

    state = state.copyWith(isLoading: true);
    try {
      final repository = ref.read(catalogsRepositoryProvider);
      final items = await repository.getTypes(
        groupName,
        forceRefresh: forceRefresh,
      );
      final updatedTypes = Map<String, List<CatalogItemDto>>.from(
        state.cachedTypes,
      );
      updatedTypes[groupName] = items;
      state = state.copyWith(cachedTypes: updatedTypes, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // optionally log or show error
    }
  }

  Future<void> fetchStateCatalog(
    String groupName, {
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh && state.cachedStates.containsKey(groupName)) return;

    state = state.copyWith(isLoading: true);
    try {
      final repository = ref.read(catalogsRepositoryProvider);
      final items = await repository.getStates(
        groupName,
        forceRefresh: forceRefresh,
      );
      final updatedStates = Map<String, List<CatalogItemDto>>.from(
        state.cachedStates,
      );
      updatedStates[groupName] = items;
      state = state.copyWith(cachedStates: updatedStates, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // optionally log or show error
    }
  }

  String getTypeName(String typeGroup, String? code) {
    if (code == null || code.isEmpty) return '';
    final list = state.cachedTypes[typeGroup];
    if (list == null || list.isEmpty) return code;
    try {
      return list.firstWhere((c) => c.code == code).name;
    } catch (_) {
      return code;
    }
  }

  String getStateName(String stateGroup, String? code) {
    if (code == null || code.isEmpty) return '';
    final list = state.cachedStates[stateGroup];
    if (list == null || list.isEmpty) return code;
    try {
      return list.firstWhere((c) => c.code == code).name;
    } catch (_) {
      return code;
    }
  }
}
