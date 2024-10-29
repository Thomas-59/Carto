import 'package:flutter/material.dart';

import '../widgets/MapWidget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            body:
              //page);
            Center(
              child: MapWidget(isDarkMode: _isDarkMode),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(!_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
            ),
          );
        }
    );
  }
}
