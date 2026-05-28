import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/now_playing_provider.dart';
import 'package:remote_content_explorer/features/movies/presentation/widgets/carousel_shell.dart';
import 'package:remote_content_explorer/features/movies/presentation/widgets/error_retry.dart';
import 'package:remote_content_explorer/features/movies/presentation/widgets/movie_card.dart';

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
    final AsyncValue<List<Movie>> state = ref.watch(nowPlayingProvider);

    return state.when(
      loading: () => const CarouselShell(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (Object _, StackTrace __) => CarouselShell(
        child: ErrorRetry(
          onRetry: () => ref.invalidate(nowPlayingProvider),
        ),
      ),
      data: (List<Movie> movies) => CarouselShell(
        child: PageView.builder(
          controller: _controller,
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) => MovieCard(
            movie: movies[index],
            controller: _controller,
            index: index,
          ),
        ),
      ),
    );
  }
}
