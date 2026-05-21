// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastResponse _$CastResponseFromJson(Map<String, dynamic> json) => CastResponse(
  id: (json['id'] as num).toInt(),
  cast: (json['cast'] as List<dynamic>)
      .map((e) => ActorModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);
