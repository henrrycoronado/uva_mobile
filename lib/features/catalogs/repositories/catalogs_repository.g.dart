// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalogs_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(catalogsRepository)
final catalogsRepositoryProvider = CatalogsRepositoryProvider._();

final class CatalogsRepositoryProvider
    extends
        $FunctionalProvider<
          CatalogsRepository,
          CatalogsRepository,
          CatalogsRepository
        >
    with $Provider<CatalogsRepository> {
  CatalogsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'catalogsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$catalogsRepositoryHash();

  @$internal
  @override
  $ProviderElement<CatalogsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CatalogsRepository create(Ref ref) {
    return catalogsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CatalogsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CatalogsRepository>(value),
    );
  }
}

String _$catalogsRepositoryHash() =>
    r'3ceb4266c1474e64b6015b2c8d86045101abbc5b';
