import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_content_explorer/core/helpers/result.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/domain/usecases/search_movies.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/usecase_providers.dart';

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }
}

final NotifierProvider<SearchQueryNotifier, String> searchQueryProvider =
    NotifierProvider.autoDispose<SearchQueryNotifier, String>(
      SearchQueryNotifier.new,
    );

final FutureProvider<List<Movie>> movieSearchProvider =
    FutureProvider.autoDispose<List<Movie>>((Ref ref) async {
      final String query = ref.watch<String>(searchQueryProvider).trim();
      if (query.isEmpty) {
        return const <Movie>[];
      }

      final Completer<void> debounce = Completer<void>();
      final Timer timer = Timer(
        const Duration(milliseconds: 500),
        debounce.complete,
      );
      ref.onDispose(() {
        timer.cancel();
        if (!debounce.isCompleted) {
          debounce.completeError(StateError('search debounce cancelled'));
        }
      });
      await debounce.future;

      final SearchMovies useCase = ref.watch<SearchMovies>(
        searchMoviesUseCaseProvider,
      );
      final Result<List<Movie>> result = await useCase.call(query);
      return result.getOrThrow();
    });
