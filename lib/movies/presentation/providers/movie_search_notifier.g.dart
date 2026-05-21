// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_search_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MovieSearchNotifier)
final movieSearchProvider = MovieSearchNotifierProvider._();

final class MovieSearchNotifierProvider
    extends $NotifierProvider<MovieSearchNotifier, MovieListState> {
  MovieSearchNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'movieSearchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$movieSearchNotifierHash();

  @$internal
  @override
  MovieSearchNotifier create() => MovieSearchNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MovieListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MovieListState>(value),
    );
  }
}

String _$movieSearchNotifierHash() =>
    r'0b71ac45d1afaf9e65f38b2dd18548ada16fe3f5';

abstract class _$MovieSearchNotifier extends $Notifier<MovieListState> {
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
