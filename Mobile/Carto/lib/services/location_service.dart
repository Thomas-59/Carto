import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

/// The service to locate the user
class LocationService {
  /// A stream to track the user position
  StreamSubscription<Position>? _positionStreamSubscription;

  /// Request the permission to use the location service when the application is used
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

  /// Start to track the user position
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

  /// Stop to track the user position
  void stopLocationUpdates() {
    _positionStreamSubscription?.cancel();
  }

  /// Get the current position of the user
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
