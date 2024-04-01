import 'package:flutter/material.dart';
import 'package:movies_app/utils/routes.dart';
import 'package:movies_app/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      theme: ThemeClass.lightTheme(),
      darkTheme: ThemeClass.darkTheme(),
      themeMode: ThemeMode.system,
      routes: MainRoute.mainRoutes,
    );
  }
}
