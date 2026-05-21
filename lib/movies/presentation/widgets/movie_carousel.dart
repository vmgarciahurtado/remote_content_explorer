import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_content_explorer/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/movies/presentation/providers/now_playing_notifier.dart';

class MovieCarousel extends ConsumerStatefulWidget {
  const MovieCarousel({super.key});

  @override
  ConsumerState<MovieCarousel> createState() => _MovieCarouselState();
}

class _MovieCarouselState extends ConsumerState<MovieCarousel> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.82);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(nowPlayingProvider);

    if (s.showInitialLoader) {
      return const _CarouselShell(child: Center(child: CircularProgressIndicator()));
    }

    if (s.showInitialError) {
      return _CarouselShell(
        child: _ErrorRetry(
          onRetry: () => ref.read(nowPlayingProvider.notifier).retry(),
        ),
      );
    }

    return _CarouselShell(
      child: PageView.builder(
        controller: _controller,
        itemCount: s.movies.length,
        itemBuilder: (context, index) => _MovieCard(
          movie: s.movies[index],
          controller: _controller,
          index: index,
        ),
      ),
    );
  }
}

class _CarouselShell extends StatelessWidget {
  const _CarouselShell({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.56,
      child: child,
    );
  }
}

class _MovieCard extends StatelessWidget {
  const _MovieCard({
    required this.movie,
    required this.controller,
    required this.index,
  });

  final Movie movie;
  final PageController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double scale = 0.9;
        if (controller.position.haveDimensions) {
          final offset = (controller.page! - index).abs();
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
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const ColoredBox(
                    color: Colors.black12,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) => const ColoredBox(
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

class _ErrorRetry extends StatelessWidget {
  const _ErrorRetry({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.wifi_off_rounded,
            size: 48,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 12),
          Text(
            'No se pudo cargar el contenido',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}
