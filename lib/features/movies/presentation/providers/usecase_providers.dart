import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_content_explorer/features/movies/domain/usecases/get_movie_cast.dart';
import 'package:remote_content_explorer/features/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:remote_content_explorer/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:remote_content_explorer/features/movies/domain/usecases/search_movies.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/repositories/movie_repository_impl.dart';

final Provider<GetNowPlayingMovies> getNowPlayingMoviesProvider =
    Provider<GetNowPlayingMovies>((Ref ref) {
      return GetNowPlayingMovies(ref.watch(movieRepositoryProvider));
    });

final Provider<GetPopularMovies> getPopularMoviesProvider =
    Provider<GetPopularMovies>((Ref ref) {
      return GetPopularMovies(ref.watch(movieRepositoryProvider));
    });

final Provider<GetMovieCast> getMovieCastProvider = Provider<GetMovieCast>((
  Ref ref,
) {
  return GetMovieCast(ref.watch(movieRepositoryProvider));
});

final Provider<SearchMovies> searchMoviesUseCaseProvider =
    Provider<SearchMovies>((Ref ref) {
      return SearchMovies(ref.watch(movieRepositoryProvider));
    });
