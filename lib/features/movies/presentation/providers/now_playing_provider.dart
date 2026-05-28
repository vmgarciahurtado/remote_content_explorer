import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_content_explorer/core/network/error_handler/failures.dart';
import 'package:remote_content_explorer/core/network/result.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/usecase_providers.dart';

final FutureProvider<List<Movie>> nowPlayingProvider =
    FutureProvider<List<Movie>>((Ref ref) async {
      final GetNowPlayingMovies useCase = ref.watch<GetNowPlayingMovies>(
        getNowPlayingMoviesProvider,
      );
      final Result<List<Movie>> result = await useCase.call();

      return switch (result) {
        Success<List<Movie>>(data: final List<Movie> movies) => movies,
        FailureResult<List<Movie>>(failure: final Failure failure) =>
          throw failure,
      };
    });
