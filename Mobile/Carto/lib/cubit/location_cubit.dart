
import 'package:bloc/bloc.dart';
import 'package:carto/cubit/location_state.dart';
import 'package:geolocator/geolocator.dart';

import '../services/location_service.dart';

class LocationCubit extends Cubit<LocationState> {
  // final WeatherService weatherService = WeatherService();
  final LocationService _locationService;

  LocationCubit(this._locationService) : super(LocationInitial());

  Future<void> startLocationUpdates() async {
    try {
      emit(LocationLoading());

      await _locationService.startLocationUpdates((Position position) {
        emit(LocationUpdated(position));
      });
    } catch (e) {
      emit(LocationError('Erreur lors de la récupération de la position: $e'));
    }
  }

  void stopLocationUpdates() {
    _locationService.stopLocationUpdates();
    emit(LocationInitial());
  }
}