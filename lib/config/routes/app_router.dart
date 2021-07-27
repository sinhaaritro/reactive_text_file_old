import 'package:flutter/material.dart';
import 'package:reactive_text_file/screen/home_screen/home_screen.dart';

import 'route_exception.dart';

class AppRouter {
  static const home = '/';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(
            title: 'Flutter Demo Home Page',
          ),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
