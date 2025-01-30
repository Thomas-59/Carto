import 'package:carto/carto_app.dart';
import 'package:carto/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// The initializer of the application
Future<void> main() async {
  final locationService = LocationService();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  await Supabase.initialize(
    url: 'https://kiadpblpsnboeoidjngf.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtpYWRwYmxwc25ib2VvaWRqbmdmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzIwMTEzMTQsImV4cCI6MjA0NzU4NzMxNH0.xQuUlGX0x76A0D7ukP8L-rDyxKtc1sCs49QIQPNahBw',
  );
  runApp(CartoApp(locationService: locationService));
}