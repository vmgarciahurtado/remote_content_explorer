import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/popular_movies_provider.dart';
import 'package:remote_content_explorer/features/movies/presentation/widgets/error_retry.dart';
import 'package:remote_content_explorer/features/movies/presentation/widgets/list_shell.dart';
import 'package:remote_content_explorer/features/movies/presentation/widgets/popular_card.dart';

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
    _controller = PageController(viewportFraction: 0.3);
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (!_controller.hasClients) return;
      final List<Movie> movies =
          ref.read(popularMoviesProvider).value ?? <Movie>[];
      if (movies.isEmpty) return;
      final int next = ((_controller.page?.round() ?? 0) + 1) % movies.length;
      unawaited(_controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      ));
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Movie>> state = ref.watch(popularMoviesProvider);
    final List<Movie> movies = state.value ?? <Movie>[];

    if (state.isLoading && movies.isEmpty) {
      return const ListShell(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.hasError && movies.isEmpty) {
      return ListShell(
        child: ErrorRetry(
          compact: true,
          onRetry: () => ref.invalidate(popularMoviesProvider),
        ),
      );
    }

    return ListShell(
      child: PageView.builder(
        padEnds: false,
        controller: _controller,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) =>
            PopularCard(movie: movies[index]),
      ),
    );
  }
}
