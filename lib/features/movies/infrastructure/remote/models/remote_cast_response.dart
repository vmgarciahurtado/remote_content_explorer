import 'package:remote_content_explorer/features/movies/infrastructure/remote/models/remote_actor_model.dart';

class RemoteCastResponse {
  const RemoteCastResponse({
    required this.id,
    required this.cast,
  });

  final int id;
  final List<RemoteActorModel> cast;
}
