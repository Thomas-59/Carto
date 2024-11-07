import 'package:carto/views/pages/home_page.dart';
import 'package:carto/views/pages/suggestion_page.dart';
import 'package:flutter/material.dart';

class CartoApp extends StatelessWidget {
  const CartoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const MyHomePage(),
        '/suggestion': (context) => SuggestionPage(),
      }
    );
  }
}