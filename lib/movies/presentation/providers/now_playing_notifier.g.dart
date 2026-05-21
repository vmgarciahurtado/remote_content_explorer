// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'now_playing_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NowPlayingNotifier)
final nowPlayingProvider = NowPlayingNotifierProvider._();

final class NowPlayingNotifierProvider
    extends $NotifierProvider<NowPlayingNotifier, MovieListState> {
  NowPlayingNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nowPlayingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nowPlayingNotifierHash();

  @$internal
  @override
  NowPlayingNotifier create() => NowPlayingNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MovieListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MovieListState>(value),
    );
  }
}

String _$nowPlayingNotifierHash() =>
    r'eee2eb12d3c8653edafe2fa623b3f23aca45c8fd';

abstract class _$NowPlayingNotifier extends $Notifier<MovieListState> {
  MovieListState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MovieListState, MovieListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MovieListState, MovieListState>,
              MovieListState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
