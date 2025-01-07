import 'package:carto/data_manager.dart';
import 'package:flutter/material.dart';

import '../widgets/map_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _firstLaunch = true;
  MapWidget map = const MapWidget();

  @override
  void initState() {
    _initApp();
    super.initState();
  }

  Future<void> _initApp() async {
    await Future.delayed(const Duration(seconds: 3)); //mounted check, DON'T delete this
    await DataManager.getInstance();
    DataManager.establishmentsFuture.whenComplete(
      () {
        setState(() {
          _firstLaunch = false;
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 216, 184, 253),
          body: _firstLaunch ? _initScreen(context) : _mapScreen(context),
        );
      },
    );
  }

  Widget _initScreen(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/logo/logo_purple.png"),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget _mapScreen(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: map,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding( padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: FloatingActionButton(
                  onPressed: () {
                    DataManager.isLogged ?
                    Navigator.pushNamed(context, '/manage',)
                        : Navigator.pushNamed(context, '/login',);
                  },
                  child: DataManager.isLogged ?
                  const Icon(Icons.account_box) : //TODO change by user picture if logged
                  const Icon(Icons.account_box),
                )
            ),
          ],
        )
      ],
    );
  }
}