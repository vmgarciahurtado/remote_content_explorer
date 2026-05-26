import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_content_explorer/features/movies/di/movies_di.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/movie_list_state.dart';

final popularMoviesProvider =
    NotifierProvider<PopularMoviesNotifier, MovieListState>(PopularMoviesNotifier.new);

class PopularMoviesNotifier extends Notifier<MovieListState> {
  int _currentPage = 0;
  bool _isFetching = false;

  @override
  MovieListState build() {
    _fetch();
    return const MovieListState(isLoading: true);
  }

  Future<void> _fetch() async {
    if (_isFetching) return;
    _isFetching = true;
    _currentPage++;

    final (movies, failure) = await ref
        .read(getPopularMoviesProvider)
        .call(page: _currentPage);

    if (failure != null) {
      _currentPage--;
      state = state.copyWith(isLoading: false, hasError: true);
    } else {
      state = MovieListState(
        movies: [...state.movies, ...movies!],
        isLoading: false,
      );
    }

    _isFetching = false;
  }

  Future<void> loadNextPage() => _fetch();

  Future<void> retry() async {
    _currentPage = 0;
    _isFetching = false;
    state = const MovieListState(isLoading: true);
    await _fetch();
  }
}
