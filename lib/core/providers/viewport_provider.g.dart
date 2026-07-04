// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewport_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ViewportState)
final viewportStateProvider = ViewportStateProvider._();

final class ViewportStateProvider
    extends $NotifierProvider<ViewportState, Viewport> {
  ViewportStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'viewportStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$viewportStateHash();

  @$internal
  @override
  ViewportState create() => ViewportState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Viewport value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Viewport>(value),
    );
  }
}

String _$viewportStateHash() => r'6c9fa489d90bbbaea5ad155183002b809ee018ac';

abstract class _$ViewportState extends $Notifier<Viewport> {
  Viewport build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Viewport, Viewport>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Viewport, Viewport>,
              Viewport,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
