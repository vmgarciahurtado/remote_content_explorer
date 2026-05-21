// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(movieRemoteDatasource)
final movieRemoteDatasourceProvider = MovieRemoteDatasourceProvider._();

final class MovieRemoteDatasourceProvider
    extends
        $FunctionalProvider<
          MovieRemoteDatasource,
          MovieRemoteDatasource,
          MovieRemoteDatasource
        >
    with $Provider<MovieRemoteDatasource> {
  MovieRemoteDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'movieRemoteDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$movieRemoteDatasourceHash();

  @$internal
  @override
  $ProviderElement<MovieRemoteDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MovieRemoteDatasource create(Ref ref) {
    return movieRemoteDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MovieRemoteDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MovieRemoteDatasource>(value),
    );
  }
}

String _$movieRemoteDatasourceHash() =>
    r'0e31f7a3cb3b1da67086176a2e95f3fba0aac5cc';

@ProviderFor(movieRepository)
final movieRepositoryProvider = MovieRepositoryProvider._();

final class MovieRepositoryProvider
    extends
        $FunctionalProvider<MovieRepository, MovieRepository, MovieRepository>
    with $Provider<MovieRepository> {
  MovieRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'movieRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$movieRepositoryHash();

  @$internal
  @override
  $ProviderElement<MovieRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MovieRepository create(Ref ref) {
    return movieRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MovieRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MovieRepository>(value),
    );
  }
}

String _$movieRepositoryHash() => r'302b1d7ad12045a6bb9f761b2a65a225fb3244b3';

@ProviderFor(getNowPlayingMovies)
final getNowPlayingMoviesProvider = GetNowPlayingMoviesProvider._();

final class GetNowPlayingMoviesProvider
    extends
        $FunctionalProvider<
          GetNowPlayingMovies,
          GetNowPlayingMovies,
          GetNowPlayingMovies
        >
    with $Provider<GetNowPlayingMovies> {
  GetNowPlayingMoviesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getNowPlayingMoviesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getNowPlayingMoviesHash();

  @$internal
  @override
  $ProviderElement<GetNowPlayingMovies> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetNowPlayingMovies create(Ref ref) {
    return getNowPlayingMovies(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetNowPlayingMovies value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetNowPlayingMovies>(value),
    );
  }
}

String _$getNowPlayingMoviesHash() =>
    r'71389189da5c229e0133a462694ad670cd23358c';

@ProviderFor(getPopularMovies)
final getPopularMoviesProvider = GetPopularMoviesProvider._();

final class GetPopularMoviesProvider
    extends
        $FunctionalProvider<
          GetPopularMovies,
          GetPopularMovies,
          GetPopularMovies
        >
    with $Provider<GetPopularMovies> {
  GetPopularMoviesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPopularMoviesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPopularMoviesHash();

  @$internal
  @override
  $ProviderElement<GetPopularMovies> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetPopularMovies create(Ref ref) {
    return getPopularMovies(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetPopularMovies value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetPopularMovies>(value),
    );
  }
}

String _$getPopularMoviesHash() => r'13b1eae4a9923bba89e6eebfaed05cdda8268858';

@ProviderFor(getMovieCast)
final getMovieCastProvider = GetMovieCastProvider._();

final class GetMovieCastProvider
    extends $FunctionalProvider<GetMovieCast, GetMovieCast, GetMovieCast>
    with $Provider<GetMovieCast> {
  GetMovieCastProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getMovieCastProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getMovieCastHash();

  @$internal
  @override
  $ProviderElement<GetMovieCast> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetMovieCast create(Ref ref) {
    return getMovieCast(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetMovieCast value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetMovieCast>(value),
    );
  }
}

String _$getMovieCastHash() => r'942c68652df4e48568a1fd2afa8ad2eed8b42cb6';

@ProviderFor(searchMovies)
final searchMoviesProvider = SearchMoviesProvider._();

final class SearchMoviesProvider
    extends $FunctionalProvider<SearchMovies, SearchMovies, SearchMovies>
    with $Provider<SearchMovies> {
  SearchMoviesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchMoviesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchMoviesHash();

  @$internal
  @override
  $ProviderElement<SearchMovies> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SearchMovies create(Ref ref) {
    return searchMovies(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchMovies value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchMovies>(value),
    );
  }
}

String _$searchMoviesHash() => r'1619d5cc427e28b6d9113abfb25e16edfb0bb6b7';
