import 'package:remote_content_explorer/features/movies/infrastructure/remote/models/remote_actor_model.dart';

class RemoteCastResponse {
  const RemoteCastResponse({
    required this.id,
    required this.cast,
  });

  factory RemoteCastResponse.fromJson(Map<String, dynamic> json) =>
      RemoteCastResponse(
        id: (json['id'] as num).toInt(),
        cast: (json['cast'] as List<dynamic>)
            .map(
              (dynamic e) =>
                  RemoteActorModel.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );

  final int id;
  final List<RemoteActorModel> cast;
}
