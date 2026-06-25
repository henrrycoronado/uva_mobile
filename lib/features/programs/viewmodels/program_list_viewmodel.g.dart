// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_list_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProgramSearchQuery)
final programSearchQueryProvider = ProgramSearchQueryProvider._();

final class ProgramSearchQueryProvider
    extends $NotifierProvider<ProgramSearchQuery, String> {
  ProgramSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'programSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$programSearchQueryHash();

  @$internal
  @override
  ProgramSearchQuery create() => ProgramSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$programSearchQueryHash() =>
    r'8c014beee2b9432f473f14e2bc1e8d4ed4fe7049';

abstract class _$ProgramSearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ProgramListViewModel)
final programListViewModelProvider = ProgramListViewModelProvider._();

final class ProgramListViewModelProvider
    extends
        $AsyncNotifierProvider<ProgramListViewModel, List<ProgramResponseDto>> {
  ProgramListViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'programListViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$programListViewModelHash();

  @$internal
  @override
  ProgramListViewModel create() => ProgramListViewModel();
}

String _$programListViewModelHash() =>
    r'354df17e8b2bd37b35661877b721b43308e97345';

abstract class _$ProgramListViewModel
    extends $AsyncNotifier<List<ProgramResponseDto>> {
  FutureOr<List<ProgramResponseDto>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<ProgramResponseDto>>,
              List<ProgramResponseDto>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ProgramResponseDto>>,
                List<ProgramResponseDto>
              >,
              AsyncValue<List<ProgramResponseDto>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
