import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_content_explorer/core/network/error_handler/failures.dart';
import 'package:remote_content_explorer/core/network/result.dart';
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

      await Future<void>.delayed(const Duration(milliseconds: 400));

      final SearchMovies useCase = ref.watch<SearchMovies>(
        searchMoviesUseCaseProvider,
      );
      final Result<List<Movie>> result = await useCase.call(query);

      return switch (result) {
        Success<List<Movie>>(data: final List<Movie> movies) => movies,
        FailureResult<List<Movie>>(failure: final Failure failure) =>
          throw failure,
      };
    });
