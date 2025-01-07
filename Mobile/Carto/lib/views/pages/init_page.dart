import 'dart:async';

import 'package:carto/models/establishment.dart';
import 'package:carto/views/widgets/constants.dart';
import 'package:flutter/material.dart';

import '../../data_manager.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {

  @override
  Widget build(BuildContext context) {
    _initApp();
    return LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
              body:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset("assets/logo/logo_purple.png")
                  ),
                  const CircularProgressIndicator(),
                ],
              ),
            backgroundColor: purple,
          );
        }
    );
  }

  Future<void> _initApp() async {
    await Future.delayed(const Duration(seconds: 3)); //mounted check, DON'T delete this
    await DataManager.getInstance();
    DataManager.establishmentsFuture.whenComplete(
        Navigator.pushNamed(context, '/home',) as FutureOr<void> Function()
    );
  }
}
