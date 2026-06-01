import 'package:flutter_test/flutter_test.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/mappers/remote_actor_mapper.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/mappers/remote_movie_mapper.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/models/remote_actor_model.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/models/remote_cast_response.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/models/remote_movie_model.dart';
import 'package:remote_content_explorer/features/movies/infrastructure/remote/models/remote_movie_response.dart';

void main() {
  group('RemoteMovieMapper.movieModelFromJson', () {
    test(
      'given a valid JSON map when fromJson is called '
      'then all fields are parsed correctly',
      () {
        final Map<String, Object> json = <String, Object>{
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
          'genre_ids': <int>[28, 12],
          'adult': false,
          'video': false,
          'original_language': 'en',
        };

        final RemoteMovieModel model =
            RemoteMovieMapper.movieModelFromJson(json);

        expect(model.id, 1);
        expect(model.title, 'Batman');
        expect(model.posterPath, '/batman.jpg');
        expect(model.genreIds, <int>[28, 12]);
      },
    );
  });

  group('RemoteMovieMapper.movieResponseFromJson', () {
    test(
      'given a valid JSON map when fromJson is called '
      'then results and pagination fields are parsed correctly',
      () {
        final Map<String, Object> json = <String, Object>{
          'page': 1,
          'total_pages': 10,
          'total_results': 200,
          'results': <Map<String, Object>>[
            <String, Object>{
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

        final RemoteMovieResponse response =
            RemoteMovieMapper.movieResponseFromJson(json);

        expect(response.page, 1);
        expect(response.totalPages, 10);
        expect(response.results.length, 1);
        expect(response.results.first.id, 1);
      },
    );
  });

  group('RemoteActorMapper.actorModelFromJson', () {
    test(
      'given a valid JSON map when fromJson is called '
      'then all fields including nullable profilePath are parsed correctly',
      () {
        final Map<String, Object> json = <String, Object>{
          'id': 10,
          'name': 'Christian Bale',
          'character': 'Bruce Wayne',
          'profile_path': '/bale.jpg',
        };

        final RemoteActorModel model =
            RemoteActorMapper.actorModelFromJson(json);

        expect(model.id, 10);
        expect(model.name, 'Christian Bale');
        expect(model.profilePath, '/bale.jpg');
      },
    );
  });

  group('RemoteActorMapper.castResponseFromJson', () {
    test(
      'given a valid JSON map when fromJson is called '
      'then the id and cast list are parsed correctly',
      () {
        final Map<String, Object> json = <String, Object>{
          'id': 99,
          'cast': <Map<String, Object?>>[
            <String, Object?>{
              'id': 10,
              'name': 'Christian Bale',
              'character': 'Bruce Wayne',
              'profile_path': null,
            },
          ],
        };

        final RemoteCastResponse response =
            RemoteActorMapper.castResponseFromJson(json);

        expect(response.id, 99);
        expect(response.cast.length, 1);
        expect(response.cast.first.name, 'Christian Bale');
      },
    );
  });
}
