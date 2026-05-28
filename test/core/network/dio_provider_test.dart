import 'package:dio/src/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remote_content_explorer/core/network/dio_provider.dart';

void main() {
  setUpAll(() {
    dotenv.loadFromString(
      envString:
          'API_KEY=test\n'
          'BASE_URL=https://api.themoviedb.org/3/\n'
          'IMAGE_BASE_URL=https://image.tmdb.org/t/p/w500\n'
          'ACTOR_IMAGE_BASE_URL=https://image.tmdb.org/t/p/w185',
    );
  });

  group('dioProvider', () {
    test(
      'given the provider is read '
      'when Dio is created '
      'then it is configured with the TMDB base URL and timeouts',
      () {
        // given
        final ProviderContainer container = ProviderContainer();
        addTearDown(container.dispose);

        // when
        final Dio dio = container.read(dioProvider);

        // then
        expect(dio.options.baseUrl, 'https://api.themoviedb.org/3/');
        expect(dio.options.connectTimeout, const Duration(seconds: 5));
        expect(dio.options.receiveTimeout, const Duration(seconds: 5));
        expect(dio.options.queryParameters['language'], 'es-ES');
      },
    );
  });
}
