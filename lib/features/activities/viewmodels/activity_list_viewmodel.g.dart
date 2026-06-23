// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_list_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ActivityListViewModel)
final activityListViewModelProvider = ActivityListViewModelFamily._();

final class ActivityListViewModelProvider
    extends
        $AsyncNotifierProvider<
          ActivityListViewModel,
          List<ActivityResponseDto>
        > {
  ActivityListViewModelProvider._({
    required ActivityListViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'activityListViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$activityListViewModelHash();

  @override
  String toString() {
    return r'activityListViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ActivityListViewModel create() => ActivityListViewModel();

  @override
  bool operator ==(Object other) {
    return other is ActivityListViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$activityListViewModelHash() =>
    r'6a0ac5965d54634397f1751581b02745e1874d76';

final class ActivityListViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          ActivityListViewModel,
          AsyncValue<List<ActivityResponseDto>>,
          List<ActivityResponseDto>,
          FutureOr<List<ActivityResponseDto>>,
          String
        > {
  ActivityListViewModelFamily._()
    : super(
        retry: null,
        name: r'activityListViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ActivityListViewModelProvider call(String programCode) =>
      ActivityListViewModelProvider._(argument: programCode, from: this);

  @override
  String toString() => r'activityListViewModelProvider';
}

abstract class _$ActivityListViewModel
    extends $AsyncNotifier<List<ActivityResponseDto>> {
  late final _$args = ref.$arg as String;
  String get programCode => _$args;

  FutureOr<List<ActivityResponseDto>> build(String programCode);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<ActivityResponseDto>>,
              List<ActivityResponseDto>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ActivityResponseDto>>,
                List<ActivityResponseDto>
              >,
              AsyncValue<List<ActivityResponseDto>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
