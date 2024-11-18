
import 'package:geolocator/geolocator.dart';

class LocationState {
}

class LocationInitial extends LocationState {
  LocationInitial();
}

class LocationUpdated extends LocationState {
  final Position position;

  LocationUpdated(this.position);
}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);
}

class LocationLoading extends LocationState {
  LocationLoading();
}