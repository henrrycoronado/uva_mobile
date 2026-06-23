// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalogs_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CatalogsViewModel)
final catalogsViewModelProvider = CatalogsViewModelProvider._();

final class CatalogsViewModelProvider
    extends $NotifierProvider<CatalogsViewModel, CatalogsState> {
  CatalogsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'catalogsViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$catalogsViewModelHash();

  @$internal
  @override
  CatalogsViewModel create() => CatalogsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CatalogsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CatalogsState>(value),
    );
  }
}

String _$catalogsViewModelHash() => r'dbbc8ba1788aaa9185d1186912be6703a5a6408e';

abstract class _$CatalogsViewModel extends $Notifier<CatalogsState> {
  CatalogsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CatalogsState, CatalogsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CatalogsState, CatalogsState>,
              CatalogsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
