import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remote_content_explorer/core/network/dio_provider.dart';

void main() {
  group('dioProvider', () {
    test(
      'given the provider is read '
      'when Dio is created '
      'then it is configured with the TMDB base URL and timeouts',
      () {
        // given
        final container = ProviderContainer();
        addTearDown(container.dispose);

        // when
        final dio = container.read(dioProvider);

        // then
        expect(dio.options.baseUrl, 'https://api.themoviedb.org/3/');
        expect(dio.options.connectTimeout, const Duration(seconds: 5));
        expect(dio.options.receiveTimeout, const Duration(seconds: 5));
        expect(dio.options.queryParameters['language'], 'es-ES');
      },
    );
  });
}
