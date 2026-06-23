// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_contact_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PortfolioContactViewModel)
final portfolioContactViewModelProvider = PortfolioContactViewModelProvider._();

final class PortfolioContactViewModelProvider
    extends $NotifierProvider<PortfolioContactViewModel, ContactModel> {
  PortfolioContactViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'portfolioContactViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$portfolioContactViewModelHash();

  @$internal
  @override
  PortfolioContactViewModel create() => PortfolioContactViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContactModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContactModel>(value),
    );
  }
}

String _$portfolioContactViewModelHash() =>
    r'4d39ce638ff82744cbf8cbbfa5d0c0cbb7322822';

abstract class _$PortfolioContactViewModel extends $Notifier<ContactModel> {
  ContactModel build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ContactModel, ContactModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ContactModel, ContactModel>,
              ContactModel,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
