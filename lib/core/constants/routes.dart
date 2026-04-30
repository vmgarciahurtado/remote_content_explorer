import 'package:flutter/material.dart';
import 'package:remote_content_explorer/features/home/presentation/home_page.dart';

class AppRoutes {
  static const initialRoute = '/';
  static Map<String, WidgetBuilder> getRoutes() {
    return {initialRoute: (BuildContext context) => const HomePage()};
  }
}
