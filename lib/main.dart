import 'package:flutter/material.dart';
import 'package:learnex/UI/home/home_view.dart';

import 'package:learnex/core/routes/app_router.dart';

import 'core/di/di.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // This is the crucial line you might be missing!
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: HomeScreen.routeName,
    );
  }
}
