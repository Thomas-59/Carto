import 'package:carto/data_manager.dart';
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
                    child: FloatingActionButton(
                        onPressed: account,
                        child: DataManager.isLogged ?
                          const Icon(Icons.account_box) : //TODO change by user picture
                          const Icon(Icons.account_box),
                    )
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void account(){
    Navigator.pushNamed(context, '/login',);
  }
}
