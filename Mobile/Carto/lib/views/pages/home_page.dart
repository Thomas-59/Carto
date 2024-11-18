import 'package:flutter/material.dart';

import '../widgets/map_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    MapWidget map = MapWidget(isDarkMode: _isDarkMode);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Stack(
            children: [
              Center(
                child: map,
              ),
              bottomWidget(),
            ],
          ),
        );
      },
    );
  }

  Widget bottomWidget() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/suggestion',
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: FloatingActionButton(
              child: Icon(_isDarkMode ? Icons.dark_mode : Icons.light_mode),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
