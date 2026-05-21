import 'package:flutter/material.dart';
import 'package:remote_content_explorer/movies/domain/entities/actor.dart';

class ActorCard extends StatelessWidget {
  const ActorCard({super.key, required this.actor});

  final Actor actor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          ClipOval(
            child: SizedBox(
              width: 90,
              height: 90,
              child: actor.profilePath != null
                  ? Image.network(
                      actor.profilePath!,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const ColoredBox(
                          color: Colors.black12,
                          child: Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          const ColoredBox(
                        color: Colors.black12,
                        child: Icon(Icons.person, size: 40),
                      ),
                    )
                  : const ColoredBox(
                      color: Colors.black12,
                      child: Icon(Icons.person, size: 40),
                    ),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 90,
            child: Text(
              actor.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          if (actor.character.isNotEmpty)
            SizedBox(
              width: 90,
              child: Text(
                actor.character,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
