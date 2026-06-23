// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_program_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UpdateProgramViewModel)
final updateProgramViewModelProvider = UpdateProgramViewModelProvider._();

final class UpdateProgramViewModelProvider
    extends $AsyncNotifierProvider<UpdateProgramViewModel, void> {
  UpdateProgramViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateProgramViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateProgramViewModelHash();

  @$internal
  @override
  UpdateProgramViewModel create() => UpdateProgramViewModel();
}

String _$updateProgramViewModelHash() =>
    r'f5c5a0115a45451a56e973cae7d7661eb2c663e1';

abstract class _$UpdateProgramViewModel extends $AsyncNotifier<void> {
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
