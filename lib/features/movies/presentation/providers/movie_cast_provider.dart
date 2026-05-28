import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:remote_content_explorer/core/network/error_handler/failures.dart';
import 'package:remote_content_explorer/core/network/result.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/actor.dart';
import 'package:remote_content_explorer/features/movies/domain/usecases/get_movie_cast.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/usecase_providers.dart';

final FutureProviderFamily<List<Actor>, int> movieCastProvider = FutureProvider
    .autoDispose
    .family<List<Actor>, int>(
      (Ref ref, int movieId) async {
        ref.keepAlive();
        final GetMovieCast useCase = ref.watch<GetMovieCast>(
          getMovieCastProvider,
        );
        final Result<List<Actor>> result = await useCase.call(movieId);

        return switch (result) {
          Success<List<Actor>>(data: final List<Actor> actors) => actors,
          FailureResult<List<Actor>>(failure: final Failure failure) =>
            throw failure,
        };
      },
    );
