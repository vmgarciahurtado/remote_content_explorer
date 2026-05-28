import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:remote_content_explorer/core/network/error_handler/failure.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/actor.dart';
import 'package:remote_content_explorer/features/movies/domain/usecases/get_movie_cast.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/repositories/movie_repository_impl.dart';

final FutureProviderFamily<List<Actor>, int> movieCastProvider =
    FutureProvider.autoDispose.family<List<Actor>, int>(
      (Ref ref, int movieId) async {
        ref.keepAlive();
        final GetMovieCast useCase =
            GetMovieCast(ref.read(movieRepositoryProvider));
        final (List<Actor>? actors, Failure? failure) =
            await useCase.call(movieId);
        if (failure != null) throw failure;
        return actors ?? <Actor>[];
      },
    );
