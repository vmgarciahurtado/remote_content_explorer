// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_movies_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PopularMoviesNotifier)
final popularMoviesProvider = PopularMoviesNotifierProvider._();

final class PopularMoviesNotifierProvider
    extends $NotifierProvider<PopularMoviesNotifier, MovieListState> {
  PopularMoviesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'popularMoviesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$popularMoviesNotifierHash();

  @$internal
  @override
  PopularMoviesNotifier create() => PopularMoviesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MovieListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MovieListState>(value),
    );
  }
}

String _$popularMoviesNotifierHash() =>
    r'61166a6709293a84da8f1ee17fd9f22931b14315';

abstract class _$PopularMoviesNotifier extends $Notifier<MovieListState> {
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
