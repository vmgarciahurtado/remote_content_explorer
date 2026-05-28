import 'package:flutter/material.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    required this.movie,
    required this.controller,
    required this.index,
    super.key,
  });

  final Movie movie;
  final PageController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        double scale = 0.9;
        if (controller.position.haveDimensions) {
          final double offset = (controller.page! - index).abs();
          scale = (1.0 - offset * 0.1).clamp(0.9, 1.0);
        }
        return Transform.scale(scale: scale, child: child);
      },
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          '/movie-detail',
          arguments: movie,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Hero(
            tag: 'movie-poster-${movie.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder:
                    (
                      BuildContext context,
                      Widget child,
                      ImageChunkEvent? loadingProgress,
                    ) {
                      if (loadingProgress == null) return child;
                      return const ColoredBox(
                        color: Colors.black12,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                errorBuilder:
                    (
                      BuildContext context,
                      Object error,
                      StackTrace? stackTrace,
                    ) => const ColoredBox(
                      color: Colors.black12,
                      child: Icon(Icons.broken_image, size: 64),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
