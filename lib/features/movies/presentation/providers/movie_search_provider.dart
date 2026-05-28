import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_content_explorer/core/network/error_handler/failure.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/domain/usecases/search_movies.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/repositories/movie_repository_impl.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/movie_list_provider.dart';

final NotifierProvider<MovieSearchNotifier, MovieListState>
    movieSearchProvider =
    NotifierProvider<MovieSearchNotifier, MovieListState>(
      MovieSearchNotifier.new,
    );

class MovieSearchNotifier extends Notifier<MovieListState> {
  Timer? _debounce;
  String _currentQuery = '';
  late final SearchMovies _searchMovies;

  @override
  MovieListState build() {
    _searchMovies = SearchMovies(ref.read(movieRepositoryProvider));
    ref.onDispose(() => _debounce?.cancel());
    return const MovieListState();
  }

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

    final (List<Movie>? movies, Failure? failure) =
        await _searchMovies.call(query.trim());
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
