import 'package:carto/data_manager.dart';
import 'package:carto/viewmodel/establishment_view_model.dart';
import 'package:carto/views/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../services/location_service.dart';
import '../../models/establishment.dart';
import 'buttons.dart';

/// Give the map and control it display and setting
class MapWidget extends StatefulWidget {
  /// The key of the widget
  static final GlobalKey<_MapWidgetState> mapKey = GlobalKey<_MapWidgetState>();

  /// The initializer of the class
  const MapWidget({super.key});

  /// Set the center of the map at the given coordinate
  void setCoordinate(double latitude, double longitude) {
    final state = mapKey.currentState;
    if (state != null) {
      state.setCoordinate(latitude, longitude);
    }
  }

  /// Reload the establishments on the map
  void reload() {
    final state = mapKey.currentState;
    if (state != null) {
      state.reload();
    }
  }

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

/// The state of  MapWidget
class _MapWidgetState extends State<MapWidget> {
  /// The map controller
  final MapController _mapController = MapController();
  /// The view model to deal with all establishment
  final EstablishmentViewModel establishmentViewModel = EstablishmentViewModel();
  /// The current position of the user or null if permission denied
  Position? _currentPosition;
  /// If it the first load of the widget
  bool isFirstLoad = true;
  /// If the map is in dark mode
  bool _isDarkMode = false;
  /// The tracker of the user
  final LocationService _locationService = LocationService();

  // Default location when user do not permit to use its location
  /// The default latitude of the map
  static const double defaultLatitude = 48.8602658;
  /// The default longitude of the map
  static const double defaultLongitude = 2.3420773;

  /// Reload the establishments on the map
  void reload(){
    setState(() {
      DataManager.establishmentsFuture = establishmentViewModel.getAllEstablishment();
    });
  }

  @override
  void initState() {
    super.initState();

    _locationService.startLocationUpdates((position) {
      setState(() {
        _currentPosition = position;
        if (_currentPosition != null && isFirstLoad) {
          _mapController.move(LatLng(_currentPosition!.latitude, _currentPosition!.longitude), 15);
          isFirstLoad = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _locationService.stopLocationUpdates();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<List<Establishment>>(
            future: DataManager.establishmentsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erreur : ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Aucun établissement trouvé'));
              }

              // Marker for establishments
              List<Marker> markers = snapshot.data!.map((establishment) {
                return Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(establishment.latitude, establishment.longitude),
                  child: IconButton(onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/establishment_detail',
                      arguments: {'establishment': establishment},
                    );
                  }, icon: const Icon(Icons.location_on, color: red, size: 40)),
                );
              }).toList();

              // Marker for user position if authorized
              if (_currentPosition != null) {
                markers.add(Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                  child: const Icon(Icons.circle_rounded, color: blue, size: 20),
                ));
              }

              return FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _currentPosition != null
                      ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
                      : LatLng(defaultLatitude, defaultLongitude),
                  initialZoom: 15,
                  minZoom: 6,
                  maxZoom: 19,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                    tileBuilder: _isDarkMode
                        ? _nightModeTileBuilder
                        : _grayModeTileBuilder,
                  ),
                  MarkerLayer(markers: markers),
                ],
              );
            },
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          // Button for dark/light mode
          Positioned(
            bottom: 0,
            right: 0,
            child: BlueSquareIconButton(
                icon: _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                onPressed: () {
                  setState(() {
                    _isDarkMode = !_isDarkMode;
                  });
                }),
          ),
          // Button for recenter on map
          Positioned(
            bottom: 70,
            right: 0,
            child: BlueSquareIconButton(
                icon: Icons.center_focus_strong_rounded,
              onPressed: () {
                  _currentPosition != null
                ? _mapController.move(LatLng(_currentPosition!.latitude, _currentPosition!.longitude), 15)
                : _mapController.move(LatLng(defaultLatitude, defaultLongitude), 15);
                  },
            ),
          ),
          // Button for recenter on map
          Positioned(
            bottom: 140,
            right: 0,
            child: BlueSquareIconButton(icon: Icons.add, onPressed: () {
              if (DataManager.isLogged) {
                Navigator.pushNamed(context, '/suggestion');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Tu dois être connecté(e) avant de suggérer un lieu !', style: blueTextBold16,),
                    duration: const Duration(seconds: 3),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: white,
                    shape : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )
                  ),
                );
                Navigator.pushNamed(context, '/login');
              }
            },)
          ),
          Positioned(
            top: 70,
            right: 0,
            child: BlueSquareIconButton(icon : Icons.display_settings,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/filter',
              );
            },)
          ),
          Positioned(
            top: 70,
            left: 30,
            child: BlueSquareIconButton(
                icon: Icons.search,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/search',
                  );
                }),
          ),
        ],
      ),
    );
  }

  /// Give the gray filter to apply on the map
  Widget _grayModeTileBuilder(
      BuildContext context, Widget tileWidget, TileImage tile) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        0.2126, 0.7152, 0.0722, 0, 0,
        0.2126, 0.7152, 0.0722, 0, 0,
        0.2126, 0.7152, 0.0722, 0, 0,
        0,      0,      0,      1, 0,
      ]),
      child: tileWidget,
    );
  }

  /// Give the night filter to apply on the map
  Widget _nightModeTileBuilder(
      BuildContext context, Widget tileWidget, TileImage tile) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        0.4,   0,     0,   0, 0,
        0,     0.4,   0,   0, 0,
        0.025, 0.025, 0.5, 0, 0,
        0,     0,     0,   1, 0
      ]),
      child: tileWidget,
    );
  }

  /// Set the center of the map at the given coordinate
  void setCoordinate(double latitude, double longitude) {
    _mapController.move(LatLng(latitude, longitude), 15);
  }

}
