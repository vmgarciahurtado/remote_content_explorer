class ActorModel {
  const ActorModel({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });

  final int id;
  final String name;
  final String character;
  final String? profilePath;

  factory ActorModel.fromJson(Map<String, dynamic> json) => ActorModel(
    id: (json['id'] as num).toInt(),
    name: json['name'] as String,
    character: json['character'] as String? ?? '',
    profilePath: json['profile_path'] as String?,
  );
}
