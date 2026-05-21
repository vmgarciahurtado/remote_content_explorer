import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_content_explorer/core/constants/routes.dart';
import 'package:remote_content_explorer/core/constants/strings.dart';
import 'package:remote_content_explorer/core/theme/theme.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      initialRoute: AppRoutes.initialRoute,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routes: AppRoutes.getRoutes(),
    );
  }
}
