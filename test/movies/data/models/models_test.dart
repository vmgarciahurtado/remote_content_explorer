import 'package:flutter_test/flutter_test.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/actor_model.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/cast_response.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/movie_model.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/models/movie_response.dart';

void main() {
  group('MovieModel.fromJson', () {
    test('given a valid JSON map '
        'when fromJson is called '
        'then all fields are parsed correctly', () {
      // given
      final json = {
        'id': 1,
        'title': 'Batman',
        'original_title': 'Batman',
        'overview': 'A hero in Gotham',
        'poster_path': '/batman.jpg',
        'backdrop_path': '/gotham.jpg',
        'release_date': '2022-03-04',
        'popularity': 98.5,
        'vote_average': 7.3,
        'vote_count': 5432,
        'genre_ids': [28, 12],
        'adult': false,
        'video': false,
        'original_language': 'en',
      };

      // when
      final model = MovieModel.fromJson(json);

      // then
      expect(model.id, 1);
      expect(model.title, 'Batman');
      expect(model.posterPath, '/batman.jpg');
      expect(model.genreIds, [28, 12]);
    });
  });

  group('MovieResponse.fromJson', () {
    test('given a valid JSON map '
        'when fromJson is called '
        'then results and pagination fields are parsed correctly', () {
      // given
      final json = {
        'page': 1,
        'total_pages': 10,
        'total_results': 200,
        'results': [
          {
            'id': 1,
            'title': 'Batman',
            'original_title': 'Batman',
            'overview': '',
            'poster_path': '/batman.jpg',
            'backdrop_path': '/gotham.jpg',
            'release_date': '2022-03-04',
            'popularity': 98.5,
            'vote_average': 7.3,
            'vote_count': 5432,
            'genre_ids': <int>[],
            'adult': false,
            'video': false,
            'original_language': 'en',
          },
        ],
      };

      // when
      final response = MovieResponse.fromJson(json);

      // then
      expect(response.page, 1);
      expect(response.totalPages, 10);
      expect(response.results.length, 1);
      expect(response.results.first.id, 1);
    });
  });

  group('ActorModel.fromJson', () {
    test(
      'given a valid JSON map '
      'when fromJson is called '
      'then all fields including nullable profilePath are parsed correctly',
      () {
        // given
        final json = {
          'id': 10,
          'name': 'Christian Bale',
          'character': 'Bruce Wayne',
          'profile_path': '/bale.jpg',
        };

        // when
        final model = ActorModel.fromJson(json);

        // then
        expect(model.id, 10);
        expect(model.name, 'Christian Bale');
        expect(model.profilePath, '/bale.jpg');
      },
    );
  });

  group('CastResponse.fromJson', () {
    test('given a valid JSON map '
        'when fromJson is called '
        'then the id and cast list are parsed correctly', () {
      // given
      final json = {
        'id': 99,
        'cast': [
          {
            'id': 10,
            'name': 'Christian Bale',
            'character': 'Bruce Wayne',
            'profile_path': null,
          },
        ],
      };

      // when
      final response = CastResponse.fromJson(json);

      // then
      expect(response.id, 99);
      expect(response.cast.length, 1);
      expect(response.cast.first.name, 'Christian Bale');
    });
  });
}
