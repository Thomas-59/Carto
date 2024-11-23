import 'package:carto/cubit/location_cubit.dart';
import 'package:carto/views/pages/establishement_details_page.dart';
import 'package:carto/views/pages/home_page.dart';
import 'package:carto/views/pages/suggestion_page.dart';
import 'package:carto/views/pages/thanking_page.dart';
import 'package:carto/views/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartoApp extends StatelessWidget {
  final LocationService locationService;

  const CartoApp({super.key, required this.locationService});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => LocationCubit(locationService),
        child: MaterialApp(
          title: 'Carto',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routes: {
            '/': (context) => const MyHomePage(),
            '/suggestion': (context) => const SuggestionPage(),
            '/thank' : (context) => const ThankingPage(),
            '/etablishment_detail' : (context) => const EtablishmentDisplayPage(),
          }
        ),
    );
  }
}