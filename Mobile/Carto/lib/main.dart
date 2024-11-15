import 'package:carto/carto_app.dart';
import 'package:carto/views/services/location_service.dart';
import 'package:flutter/material.dart';

void main() {
  final locationService = LocationService();

  runApp(CartoApp(locationService: locationService));
}