import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

class LocationService {
  StreamSubscription<Position>? _positionStreamSubscription;

  Future<bool> _requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.status;
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      status = await Permission.locationWhenInUse.request();
      return status.isGranted;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    return false;
  }

  Future<void> startLocationUpdates(Function(Position) onLocationUpdate) async {
    bool hasPermission = await _requestLocationPermission();
    if (!hasPermission) return;

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 2,
    );

    _positionStreamSubscription = Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      onLocationUpdate(position);
    });
  }

  void stopLocationUpdates() {
    _positionStreamSubscription?.cancel();
  }

  Future<Position?> getCurrentLocation() async {
    bool hasPermission = await _requestLocationPermission();
    if (!hasPermission) return null;

    try {
      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      return null;
    }
  }
}
