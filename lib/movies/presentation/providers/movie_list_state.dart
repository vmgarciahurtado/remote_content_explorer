import 'package:remote_content_explorer/movies/domain/entities/movie.dart';

class MovieListState {
  const MovieListState({
    this.movies = const [],
    this.isLoading = false,
    this.hasError = false,
  });

  final List<Movie> movies;
  final bool isLoading;
  final bool hasError;

  bool get showInitialLoader => isLoading && movies.isEmpty;
  bool get showInitialError => hasError && movies.isEmpty;

  MovieListState copyWith({
    List<Movie>? movies,
    bool? isLoading,
    bool? hasError,
  }) => MovieListState(
    movies: movies ?? this.movies,
    isLoading: isLoading ?? this.isLoading,
    hasError: hasError ?? false,
  );
}
