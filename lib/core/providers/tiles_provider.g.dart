// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tiles_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TilesState)
final tilesStateProvider = TilesStateProvider._();

final class TilesStateProvider
    extends $NotifierProvider<TilesState, List<ChromaTile>> {
  TilesStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tilesStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tilesStateHash();

  @$internal
  @override
  TilesState create() => TilesState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ChromaTile> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ChromaTile>>(value),
    );
  }
}

String _$tilesStateHash() => r'044c30c846f1548496c649c354fe8f0b2f5f578c';

abstract class _$TilesState extends $Notifier<List<ChromaTile>> {
  List<ChromaTile> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<ChromaTile>, List<ChromaTile>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<ChromaTile>, List<ChromaTile>>,
              List<ChromaTile>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
