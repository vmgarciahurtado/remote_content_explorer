import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_content_explorer/core/constants/routes.dart';
import 'package:remote_content_explorer/features/movies/domain/entities/movie.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/movie_list_provider.dart';
import 'package:remote_content_explorer/features/movies/presentation/providers/movie_search_provider.dart';

class MovieSearchDelegate extends SearchDelegate<void> {
  @override
  String get searchFieldLabel => 'Buscar película...';

  @override
  List<Widget> buildActions(BuildContext context) => <Widget>[
    Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? _) => IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          ref.read(movieSearchProvider.notifier).clear();
        },
      ),
    ),
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    icon: AnimatedIcon(
      icon: AnimatedIcons.menu_arrow,
      progress: transitionAnimation,
    ),
    onPressed: () => close(context, null),
  );

  @override
  Widget buildResults(BuildContext context) => const SizedBox.shrink();

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.trim().isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.movie_filter_outlined,
              size: 56,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            const SizedBox(height: 12),
            Text(
              'Escribe para buscar',
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ],
        ),
      );
    }

    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? _) {
        ref.read(movieSearchProvider.notifier).search(query);
        final MovieListState state = ref.watch(movieSearchProvider);

        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.hasError) {
          return Center(
            child: Text(
              'Error al buscar. Verifica tu conexión.',
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          );
        }

        if (state.movies.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.search_off_rounded,
                  size: 48,
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
                const SizedBox(height: 12),
                Text(
                  'Sin resultados para "$query"',
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: state.movies.length,
          itemBuilder: (BuildContext context, int index) {
            final Movie movie = state.movies[index];
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  movie.posterPath,
                  width: 44,
                  height: 64,
                  fit: BoxFit.cover,
                  errorBuilder: (
                    BuildContext context,
                    Object error,
                    StackTrace? stackTrace,
                  ) => const SizedBox(
                    width: 44,
                    child: ColoredBox(
                      color: Colors.black12,
                      child: Icon(Icons.movie, size: 24),
                    ),
                  ),
                ),
              ),
              title: Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                movie.originalTitle,
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.outline,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                    size: 13,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    movie.voteAverage.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 11),
                  ),
                ],
              ),
              onTap: () {
                close(context, null);
                unawaited(
                  Navigator.pushNamed(
                    context,
                    AppRoutes.movieDetail,
                    arguments: movie,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
