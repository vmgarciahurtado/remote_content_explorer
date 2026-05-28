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
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final double popularity;
  final double voteAverage;
  final int voteCount;
  final List<int> genreIds;
  final bool adult;
  final bool video;
  final String originalLanguage;

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
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
            ?.map((dynamic e) => (e as num).toInt())
            .toList() ??
        <int>[],
    adult: json['adult'] as bool? ?? false,
    video: json['video'] as bool? ?? false,
    originalLanguage: json['original_language'] as String? ?? '',
  );
}
