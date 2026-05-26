import 'dart:async';

import 'package:remote_content_explorer/features/movies/di/movies_di.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/movie_list_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_search_notifier.g.dart';

@riverpod
class MovieSearchNotifier extends _$MovieSearchNotifier {
  Timer? _debounce;
  String _currentQuery = '';

  @override
  MovieListState build() => const MovieListState();

  void search(String query) {
    if (query.trim().isEmpty) {
      _cancel();
      return;
    }

    if (query == _currentQuery) return;

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () => _fetch(query));
  }

  Future<void> _fetch(String query) async {
    _currentQuery = query;
    state = const MovieListState(isLoading: true);

    final (movies, failure) = await ref.read(searchMoviesProvider).call(query.trim());
    if (failure != null) {
      state = const MovieListState(hasError: true);
    } else {
      state = MovieListState(movies: movies!);
    }
  }

  void clear() => _cancel();

  void _cancel() {
    _debounce?.cancel();
    _currentQuery = '';
    state = const MovieListState();
  }
}
