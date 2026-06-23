// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enrollment_list_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EnrollmentListViewModel)
final enrollmentListViewModelProvider = EnrollmentListViewModelFamily._();

final class EnrollmentListViewModelProvider
    extends
        $AsyncNotifierProvider<
          EnrollmentListViewModel,
          List<EnrollmentResponseDto>
        > {
  EnrollmentListViewModelProvider._({
    required EnrollmentListViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'enrollmentListViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$enrollmentListViewModelHash();

  @override
  String toString() {
    return r'enrollmentListViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EnrollmentListViewModel create() => EnrollmentListViewModel();

  @override
  bool operator ==(Object other) {
    return other is EnrollmentListViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$enrollmentListViewModelHash() =>
    r'274f86e14d11a913f85cd00c384e3616a558f09c';

final class EnrollmentListViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          EnrollmentListViewModel,
          AsyncValue<List<EnrollmentResponseDto>>,
          List<EnrollmentResponseDto>,
          FutureOr<List<EnrollmentResponseDto>>,
          String
        > {
  EnrollmentListViewModelFamily._()
    : super(
        retry: null,
        name: r'enrollmentListViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EnrollmentListViewModelProvider call(String activityCode) =>
      EnrollmentListViewModelProvider._(argument: activityCode, from: this);

  @override
  String toString() => r'enrollmentListViewModelProvider';
}

abstract class _$EnrollmentListViewModel
    extends $AsyncNotifier<List<EnrollmentResponseDto>> {
  late final _$args = ref.$arg as String;
  String get activityCode => _$args;

  FutureOr<List<EnrollmentResponseDto>> build(String activityCode);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<EnrollmentResponseDto>>,
              List<EnrollmentResponseDto>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<EnrollmentResponseDto>>,
                List<EnrollmentResponseDto>
              >,
              AsyncValue<List<EnrollmentResponseDto>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
