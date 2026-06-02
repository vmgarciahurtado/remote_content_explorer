import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_content_explorer/core/helpers/result.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/usecase_providers.dart';

final FutureProvider<List<Movie>> nowPlayingProvider =
    FutureProvider<List<Movie>>((Ref ref) async {
      final GetNowPlayingMovies useCase = ref.watch<GetNowPlayingMovies>(
        getNowPlayingMoviesProvider,
      );
      final Result<List<Movie>> result = await useCase.call();
      return result.getOrThrow();
    });
