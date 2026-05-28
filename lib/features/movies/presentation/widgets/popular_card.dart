import 'package:flutter/material.dart';
import 'package:remote_content_explorer/core/constants/routes.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';

class PopularCard extends StatelessWidget {
  const PopularCard({required this.movie, super.key});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.movieDetail,
        arguments: movie,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Hero(
          tag: 'movie-popular-${movie.id}',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              movie.posterPath,
              fit: BoxFit.cover,
              loadingBuilder: (
                BuildContext context,
                Widget child,
                ImageChunkEvent? loadingProgress,
              ) {
                if (loadingProgress == null) return child;
                return const ColoredBox(
                  color: Colors.black12,
                  child: Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
              errorBuilder: (
                BuildContext context,
                Object error,
                StackTrace? stackTrace,
              ) => const ColoredBox(
                color: Colors.black12,
                child: Icon(Icons.broken_image),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
