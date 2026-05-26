import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_content_explorer/core/constants/routes.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/popular_movies_notifier.dart';

class MovieHorizontalList extends ConsumerStatefulWidget {
  const MovieHorizontalList({super.key});

  @override
  ConsumerState<MovieHorizontalList> createState() =>
      _MovieHorizontalListState();
}

class _MovieHorizontalListState extends ConsumerState<MovieHorizontalList> {
  late final PageController _controller;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.3)..addListener(_onScroll);
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (!_controller.hasClients) return;
      final movies = ref.read(popularMoviesProvider).movies;
      if (movies.isEmpty) return;
      final next = ((_controller.page?.round() ?? 0) + 1) % movies.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_controller.position.hasContentDimensions) return;
    final atEnd =
        _controller.position.pixels >=
        _controller.position.maxScrollExtent - 200;
    if (atEnd) {
      ref.read(popularMoviesProvider.notifier).loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(popularMoviesProvider);

    if (s.showInitialLoader) {
      return const _ListShell(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (s.showInitialError) {
      return _ListShell(
        child: _ErrorRetry(
          onRetry: () => ref.read(popularMoviesProvider.notifier).retry(),
        ),
      );
    }

    return _ListShell(
      child: PageView.builder(
        padEnds: false,
        controller: _controller,
        itemCount: s.movies.length,
        itemBuilder: (context, index) => _PopularCard(movie: s.movies[index]),
      ),
    );
  }
}

class _ListShell extends StatelessWidget {
  const _ListShell({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.20,
      child: child,
    );
  }
}

class _PopularCard extends StatelessWidget {
  const _PopularCard({required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, AppRoutes.movieDetail, arguments: movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Hero(
          tag: 'movie-popular-${movie.id}',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              movie.posterPath,
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
              errorBuilder: (context, error, stackTrace) => const ColoredBox(
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

class _ErrorRetry extends StatelessWidget {
  const _ErrorRetry({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.wifi_off_rounded,
          color: Theme.of(context).colorScheme.outline,
        ),
        const SizedBox(width: 8),
        Text(
          'Error al cargar',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        const SizedBox(width: 8),
        TextButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh, size: 16),
          label: const Text('Reintentar'),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
      ],
    );
  }
}
