import 'package:flutter/material.dart';
import 'package:remote_content_explorer/movies/presentation/pages/home_page.dart';
import 'package:remote_content_explorer/movies/presentation/pages/movie_detail_page.dart';

class AppRoutes {
  AppRoutes._();

  static const initialRoute = '/';
  static const movieDetail = '/movie-detail';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      initialRoute: (_) => const HomePage(),
      movieDetail: (_) => const MovieDetailPage(),
    };
  }
}
