// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  originalTitle: json['original_title'] as String,
  overview: json['overview'] as String,
  posterPath: json['poster_path'] as String? ?? '',
  backdropPath: json['backdrop_path'] as String? ?? '',
  releaseDate: json['release_date'] as String? ?? '',
  popularity: (json['popularity'] as num).toDouble(),
  voteAverage: (json['vote_average'] as num).toDouble(),
  voteCount: (json['vote_count'] as num).toInt(),
  genreIds:
      (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      [],
  adult: json['adult'] as bool? ?? false,
  video: json['video'] as bool? ?? false,
  originalLanguage: json['original_language'] as String? ?? '',
);
