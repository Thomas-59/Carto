import 'package:carto/models/establishment_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carto/views/services/establishment_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../cubit/location_cubit.dart';
import '../../cubit/location_state.dart';
import '../../models/establishment.dart';
import '../services/location_service.dart';

class MapWidget extends StatefulWidget {
  final bool isDarkMode;
  static final GlobalKey<_MapWidgetState> mapKey = GlobalKey<_MapWidgetState>();

  const MapWidget({super.key, required this.isDarkMode});

  void setCoordinate(double latitude, double longitude) {
    final state = mapKey.currentState;
    if (state != null) {
      state.setCoordinate(latitude, longitude);
    }
  }

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final MapController _mapController = MapController();
  final EstablishmentService establishmentService = EstablishmentService();
  Position? _currentPosition;
  bool isFirstLoad = true;
  final LocationService _locationService = LocationService();
  double default_latitude = 50.63294;
  double default_longitude = 3.05843;

  late Future<List<Establishment>> _establishmentsFuture;

  @override
  void initState() {
    super.initState();
    _establishmentsFuture = establishmentService.getAllEstablishment();

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
    return BlocListener<LocationCubit, LocationState>(
      listener: (context, state) {
        if (state is LocationUpdated) {
          _mapController.move(LatLng(state.position.latitude, state.position.longitude), 15);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            FutureBuilder<List<Establishment>>(
              future: _establishmentsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erreur : ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Aucun établissement trouvé'));
                }

                // Marker for establishments
                List<Marker> markers = snapshot.data!.map((establishment) {
                  return Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(establishment.latitude, establishment.longitude),
                    child: Icon(Icons.location_on, color: Colors.red, size: 40),
                  );
                }).toList();

                // Marker for user position if authorized
                if (_currentPosition != null) {
                  markers.add(Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                    child: Icon(Icons.circle_rounded, color: Colors.blue, size: 20),
                  ));
                }

                return FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _currentPosition != null
                        ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
                        : LatLng(default_latitude, default_longitude),
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
                      tileBuilder: widget.isDarkMode
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
      ),
    );
  }

  Widget _lightModeTileBuilder(
      BuildContext context, Widget tileWidget, TileImage tile) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        1, 0, 0, 0, 0, // Red channel
        0, 1, 0, 0, 0, // Green channel
        0, 0, 1, 0, 0, // Blue channel
        0, 0, 0, 1, 0, // Alpha channel
      ]),
      child: tileWidget,
    );
  }

  Widget _grayModeTileBuilder(
      BuildContext context, Widget tileWidget, TileImage tile) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        0.2126, 0.7152, 0.0722, 0, 0,
        0.2126, 0.7152, 0.0722, 0, 0,
        0.2126, 0.7152, 0.0722, 0, 0,
        0, 0, 0, 1, 0,
      ]),
      child: tileWidget,
    );
  }

  Widget _darkenedModeTileBuilder(
      BuildContext context, Widget tileWidget, TileImage tile) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        0.75, 0, 0, 0, 0,
        0, 0.75, 0, 0, 0,
        0, 0, 0.75, 0, 0,
        0, 0, 0, 1, 0
      ]),
      child: tileWidget,
    );
  }

  Widget _nightModeTileBuilder(
      BuildContext context, Widget tileWidget, TileImage tile) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        0.4, 0, 0, 0, 0,
        0, 0.4, 0, 0, 0,
        0.025, 0.025, 0.5, 0, 0,
        0, 0, 0, 1, 0
      ]),
      child: tileWidget,
    );
  }

  // Fonction pour déplacer la carte sur les nouvelles coordonnées
  void setCoordinate(double latitude, double longitude) {
    _mapController.move(LatLng(latitude, longitude), 15);
  }
}
