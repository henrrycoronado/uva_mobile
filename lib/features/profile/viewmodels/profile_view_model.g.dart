// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProfileViewModel)
final profileViewModelProvider = ProfileViewModelProvider._();

final class ProfileViewModelProvider
    extends $AsyncNotifierProvider<ProfileViewModel, ProfileResponseDto> {
  ProfileViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileViewModelHash();

  @$internal
  @override
  ProfileViewModel create() => ProfileViewModel();
}

String _$profileViewModelHash() => r'acab6238476c7b0f87ba2cfae4631e6196ec3803';

abstract class _$ProfileViewModel extends $AsyncNotifier<ProfileResponseDto> {
  FutureOr<ProfileResponseDto> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<ProfileResponseDto>, ProfileResponseDto>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProfileResponseDto>, ProfileResponseDto>,
              AsyncValue<ProfileResponseDto>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
