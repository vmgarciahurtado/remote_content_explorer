import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_content_explorer/core/network/error_handler/failure.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/repositories/movie_repository_impl.dart';

final FutureProvider<List<Movie>> popularMoviesProvider =
    FutureProvider<List<Movie>>((Ref ref) async {
  final GetPopularMovies useCase =
      GetPopularMovies(ref.read(movieRepositoryProvider));
  final (List<Movie>? movies, Failure? failure) = await useCase.call();
  if (failure != null) throw failure;
  return movies!;
});
