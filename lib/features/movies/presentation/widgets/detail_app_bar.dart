import 'package:flutter/material.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/presentation/widgets/network_image_with_fallback.dart';

class DetailAppBar extends StatelessWidget {
  const DetailAppBar({required this.movie, super.key});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: NetworkImageWithFallback(
          url: movie.backdropPath,
          fallback: const ColoredBox(color: Colors.black26),
        ),
      ),
    );
  }
}
