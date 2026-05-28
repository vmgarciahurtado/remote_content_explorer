import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';

class MovieListState {
  const MovieListState({
    this.movies = const <Movie>[],
    this.isLoading = false,
    this.hasError = false,
  });

  final List<Movie> movies;
  final bool isLoading;
  final bool hasError;

  MovieListState copyWith({
    List<Movie>? movies,
    bool? isLoading,
    bool? hasError,
  }) => MovieListState(
    movies: movies ?? this.movies,
    isLoading: isLoading ?? this.isLoading,
    hasError: hasError ?? this.hasError,
  );
}
