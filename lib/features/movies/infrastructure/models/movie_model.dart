import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable(createToJson: false)
class MovieModel {
  const MovieModel({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
    required this.genreIds,
    required this.adult,
    required this.video,
    required this.originalLanguage,
  });

  final int id;
  final String title;
  @JsonKey(name: 'original_title')
  final String originalTitle;
  final String overview;
  @JsonKey(name: 'poster_path', defaultValue: '')
  final String posterPath;
  @JsonKey(name: 'backdrop_path', defaultValue: '')
  final String backdropPath;
  @JsonKey(name: 'release_date', defaultValue: '')
  final String releaseDate;
  final double popularity;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;
  @JsonKey(name: 'genre_ids', defaultValue: [])
  final List<int> genreIds;
  @JsonKey(defaultValue: false)
  final bool adult;
  @JsonKey(defaultValue: false)
  final bool video;
  @JsonKey(name: 'original_language', defaultValue: '')
  final String originalLanguage;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
}
