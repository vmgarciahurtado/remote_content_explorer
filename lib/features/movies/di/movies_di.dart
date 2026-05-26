import 'package:remote_content_explorer/core/network/dio_provider.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/datasources/movie_remote_datasource.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/repositories/movie_repository_impl.dart';
import 'package:remote_content_explorer/features/movies/domain/repositories/movie_repository.dart';
import 'package:remote_content_explorer/features/movies/domain/usecases/get_movie_cast.dart';
import 'package:remote_content_explorer/features/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:remote_content_explorer/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:remote_content_explorer/features/movies/domain/usecases/search_movies.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movies_di.g.dart';

@riverpod
MovieRemoteDatasource movieRemoteDatasource(Ref ref) =>
    MovieRemoteDatasource(ref.watch(dioProvider));

@riverpod
MovieRepository movieRepository(Ref ref) =>
    MovieRepositoryImpl(ref.watch(movieRemoteDatasourceProvider));

@riverpod
GetNowPlayingMovies getNowPlayingMovies(Ref ref) =>
    GetNowPlayingMovies(ref.watch(movieRepositoryProvider));

@riverpod
GetPopularMovies getPopularMovies(Ref ref) =>
    GetPopularMovies(ref.watch(movieRepositoryProvider));

@riverpod
GetMovieCast getMovieCast(Ref ref) =>
    GetMovieCast(ref.watch(movieRepositoryProvider));

@riverpod
SearchMovies searchMovies(Ref ref) =>
    SearchMovies(ref.watch(movieRepositoryProvider));
