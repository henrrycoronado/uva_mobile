// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_program_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreateProgramViewModel)
final createProgramViewModelProvider = CreateProgramViewModelProvider._();

final class CreateProgramViewModelProvider
    extends $AsyncNotifierProvider<CreateProgramViewModel, void> {
  CreateProgramViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createProgramViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createProgramViewModelHash();

  @$internal
  @override
  CreateProgramViewModel create() => CreateProgramViewModel();
}

String _$createProgramViewModelHash() =>
    r'7790c61f136402e394d481587c7e859f27b924a4';

abstract class _$CreateProgramViewModel extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
