import 'package:carto/data_manager.dart';
import 'package:carto/views/widgets/buttons.dart';
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
    MapWidget map = const MapWidget();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Stack(
            children: [
              Center(
                child: map,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding( padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: BlueSquareIconButton(
                        icon: DataManager.isLogged ?
                        Icons.account_box : //TODO change by user picture if logged
                        Icons.account_box,
                        onPressed: () {
                          DataManager.isLogged ?
                          Navigator.pushNamed(context, '/manage',)
                              : Navigator.pushNamed(context, '/login',);
                        })
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
