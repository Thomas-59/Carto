import 'package:flutter/material.dart';

import '../widgets/map_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    MapWidget map = MapWidget();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Stack(
            children: [
              Center(
                child: map,
              ),
            ],
          ),
        );
      },
    );
  }
}
