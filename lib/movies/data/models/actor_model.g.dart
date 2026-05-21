// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActorModel _$ActorModelFromJson(Map<String, dynamic> json) => ActorModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  character: json['character'] as String? ?? '',
  profilePath: json['profile_path'] as String?,
);
