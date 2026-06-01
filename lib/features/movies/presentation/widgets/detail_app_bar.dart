import 'package:flutter/material.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';

class DetailAppBar extends StatelessWidget {
  const DetailAppBar({required this.movie, super.key});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          movie.backdropPath,
          fit: BoxFit.cover,
          errorBuilder:
              (
                BuildContext context,
                Object error,
                StackTrace? stackTrace,
              ) => const ColoredBox(color: Colors.black26),
        ),
      ),
    );
  }
}
