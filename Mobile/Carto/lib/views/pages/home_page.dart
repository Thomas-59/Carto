import 'package:carto/data_manager.dart';
import 'package:carto/views/widgets/constants.dart';
import 'package:carto/views/widgets/buttons.dart';
import 'package:flutter/material.dart';

import '../widgets/map_widget.dart';

/// The home page of the application where the map with all establishment and
/// most of the access to the other page is displayed
class MyHomePage extends StatefulWidget {

  /// The initializer of the class
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// The state of the MyHomePage stateful widget
class _MyHomePageState extends State<MyHomePage> {
  /// Show if it the first launch of this page
  bool _firstLaunch = true;
  /// The map where the establishment where displayed
  MapWidget map = const MapWidget();

  @override
  void initState() {
    _initApp();
    super.initState();
  }

  /// initialise the application
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
          backgroundColor: purple,
          body: _firstLaunch ? _initScreen(context) : _mapScreen(context),
        );
      },
    );
  }

  /// Give the initialisation screen
  Widget _initScreen(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/logo/logo_purple.png"),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Récupération des données... \nCela peut prendre quelques minutes...", style: textInPageTextStyle),
          ),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }

  /// Give the home screen with the map
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
                child: BlueSquareIconButton(
                  onPressed: () {
                    DataManager.isLogged ?
                    Navigator.pushNamed(context, '/manage',)
                        : Navigator.pushNamed(context, '/login',);
                  },
                  icon: DataManager.isLogged ? Icons.account_box : //TODO change by user picture if logged
                    Icons.account_box
                )
            ),
          ],
        )
      ],
    );
  }
}