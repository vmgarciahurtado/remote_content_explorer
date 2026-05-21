import 'package:dio/dio.dart';
import 'package:remote_content_explorer/movies/data/models/cast_response.dart';
import 'package:remote_content_explorer/movies/data/models/movie_response.dart';
import 'package:retrofit/retrofit.dart';

part 'movie_remote_datasource.g.dart';

@RestApi()
abstract class MovieRemoteDatasource {
  factory MovieRemoteDatasource(Dio dio) = _MovieRemoteDatasource;

  @GET('movie/now_playing')
  Future<MovieResponse> getNowPlaying({@Query('page') int page = 1});

  @GET('movie/popular')
  Future<MovieResponse> getPopular({@Query('page') int page = 1});

  @GET('movie/{id}/credits')
  Future<CastResponse> getMovieCast(@Path('id') int movieId);

  @GET('search/movie')
  Future<MovieResponse> searchMovies({@Query('query') required String query});
}
