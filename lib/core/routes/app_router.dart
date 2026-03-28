import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learnex/UI/classes_screen/classes_view.dart';
import 'package:learnex/UI/home/home_view.dart';
import 'package:learnex/core/routes/routes.dart';

abstract class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    if (kDebugMode) {
      print('navigate to ${settings.name}');
    }
    final uri = Uri.parse(settings.name ?? "/");
    switch (uri.path) {
      case Routes.homeScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => HomeScreen(),
        );
      case Routes.classScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ClassesView(
            courseId: args['courseId'] as int,
            courseName: args['courseName'] as String,
          ),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 - Page Not Found')),
          ),
        );
    }
  }
}