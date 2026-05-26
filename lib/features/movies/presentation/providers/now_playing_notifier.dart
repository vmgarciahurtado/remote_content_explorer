import 'package:remote_content_explorer/features/movies/di/movies_di.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/movie_list_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'now_playing_notifier.g.dart';

@riverpod
class NowPlayingNotifier extends _$NowPlayingNotifier {
  int _currentPage = 0;

  @override
  MovieListState build() {
    _fetch();
    return const MovieListState(isLoading: true);
  }

  Future<void> _fetch() async {
    _currentPage++;

    final (movies, failure) = await ref
        .read(getNowPlayingMoviesProvider)
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
  }

  Future<void> retry() async {
    _currentPage = 0;
    state = const MovieListState(isLoading: true);
    await _fetch();
  }
}
