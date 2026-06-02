import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_content_explorer/core/constants/env.dart';
import 'package:remote_content_explorer/core/services/http/dio/dio_http_service.dart';
import 'package:remote_content_explorer/core/services/http/dio/dio_provider.dart';
import 'package:remote_content_explorer/core/services/http/http_service.dart';
import 'package:remote_content_explorer/features/movies/domain/repositories/movie_repository.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/repositories/remote_movie_repository_impl.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/services/image_url_resolver.dart';

final Provider<HttpService> httpServiceProvider = Provider<HttpService>((
  Ref ref,
) {
  return DioHttpService(ref.watch(dioProvider));
});

final Provider<ImageUrlResolver> imageUrlResolverProvider =
    Provider<ImageUrlResolver>((Ref ref) {
      return ImageUrlResolver(
        imageBaseUrl: Env.imageBaseUrl,
        actorImageBaseUrl: Env.actorImageBaseUrl,
        noImageUrl: Env.noImageUrl,
      );
    });

final Provider<MovieRepository> movieRepositoryProvider =
    Provider<MovieRepository>((Ref ref) {
      return RemoteMovieRepositoryImpl(
        ref.watch(httpServiceProvider),
        ref.watch(imageUrlResolverProvider),
      );
    });
