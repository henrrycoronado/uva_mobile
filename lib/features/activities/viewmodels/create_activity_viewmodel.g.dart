// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_activity_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreateActivityViewModel)
final createActivityViewModelProvider = CreateActivityViewModelProvider._();

final class CreateActivityViewModelProvider
    extends $AsyncNotifierProvider<CreateActivityViewModel, void> {
  CreateActivityViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createActivityViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createActivityViewModelHash();

  @$internal
  @override
  CreateActivityViewModel create() => CreateActivityViewModel();
}

String _$createActivityViewModelHash() =>
    r'96fed38a94d293c4bef051108c2a807526c6291a';

abstract class _$CreateActivityViewModel extends $AsyncNotifier<void> {
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
