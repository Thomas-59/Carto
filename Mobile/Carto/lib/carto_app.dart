import 'package:carto/services/location_service.dart';
import 'package:carto/views/pages/establishement_details_page.dart';
import 'package:carto/views/pages/account_page.dart';
import 'package:carto/views/pages/forgotten_password_page.dart';
import 'package:carto/views/pages/filter_page.dart';
import 'package:carto/views/pages/home_page.dart';
import 'package:carto/views/pages/search_page.dart';
import 'package:carto/views/pages/signup_page.dart';
import 'package:carto/views/pages/login_page.dart';
import 'package:carto/views/pages/manage_page.dart';
import 'package:carto/views/pages/suggestion_page.dart';
import 'package:carto/views/pages/thanking_page.dart';
import 'package:flutter/material.dart';

class CartoApp extends StatelessWidget {
  final LocationService locationService;

  const CartoApp({super.key, required this.locationService});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carto',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const MyHomePage(),
        '/suggestion': (context) => const SuggestionPage(),
        '/thank': (context) => const ThankingPage(),
        '/establishment_detail': (context) => const EstablishmentDisplayPage(),
        '/signup': (context) => const SignUpPage(),
        '/search': (context) => const SearchPage(),
        '/login' : (context) => const LoginPage(),
        '/forgotten' : (context) => const ForgottenPasswordPage(),
        '/manage' : (context) => const ManagePage(),
        '/account' : (context) => const AccountPage(),
        '/filter' : (context)=> const FilterPage(),
      },
    );
  }
}