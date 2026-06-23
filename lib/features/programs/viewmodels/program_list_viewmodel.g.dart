// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_list_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
