import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_content_explorer/core/network/dio_provider.dart';
import 'package:remote_content_explorer/features/movies/domain/repositories/movie_repository.dart';
import 'package:remote_content_explorer/features/movies/domain/usecases/get_movie_cast.dart';
import 'package:remote_content_explorer/features/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:remote_content_explorer/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:remote_content_explorer/features/movies/domain/usecases/search_movies.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/datasources/movie_remote_datasource.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/repositories/movie_repository_impl.dart';

final movieRemoteDatasourceProvider = Provider<MovieRemoteDatasource>(
  (ref) => MovieRemoteDatasource(ref.watch(dioProvider)),
);

final movieRepositoryProvider = Provider<MovieRepository>(
  (ref) => MovieRepositoryImpl(ref.watch(movieRemoteDatasourceProvider)),
);

final getNowPlayingMoviesProvider = Provider<GetNowPlayingMovies>(
  (ref) => GetNowPlayingMovies(ref.watch(movieRepositoryProvider)),
);

final getPopularMoviesProvider = Provider<GetPopularMovies>(
  (ref) => GetPopularMovies(ref.watch(movieRepositoryProvider)),
);

final getMovieCastProvider = Provider<GetMovieCast>(
  (ref) => GetMovieCast(ref.watch(movieRepositoryProvider)),
);

final searchMoviesProvider = Provider<SearchMovies>(
  (ref) => SearchMovies(ref.watch(movieRepositoryProvider)),
);
