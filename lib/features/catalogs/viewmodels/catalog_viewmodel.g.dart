// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ActivityTypesCatalogViewModel)
final activityTypesCatalogViewModelProvider =
    ActivityTypesCatalogViewModelProvider._();

final class ActivityTypesCatalogViewModelProvider
    extends
        $AsyncNotifierProvider<
          ActivityTypesCatalogViewModel,
          List<Map<String, dynamic>>
        > {
  ActivityTypesCatalogViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activityTypesCatalogViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activityTypesCatalogViewModelHash();

  @$internal
  @override
  ActivityTypesCatalogViewModel create() => ActivityTypesCatalogViewModel();
}

String _$activityTypesCatalogViewModelHash() =>
    r'ecbbb586a84433f5f8ffe0380494fce242ecadf1';

abstract class _$ActivityTypesCatalogViewModel
    extends $AsyncNotifier<List<Map<String, dynamic>>> {
  FutureOr<List<Map<String, dynamic>>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<Map<String, dynamic>>>,
              List<Map<String, dynamic>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<Map<String, dynamic>>>,
                List<Map<String, dynamic>>
              >,
              AsyncValue<List<Map<String, dynamic>>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
