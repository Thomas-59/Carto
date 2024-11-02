import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: const MapOptions(
        initialCenter: LatLng(50.63294, 3.05843),
        initialZoom: 15,
        minZoom: 6,
        maxZoom: 19,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
          tileBuilder:  widget.isDarkMode ? _nightModeTileBuilder : _darkenedModeTileBuilder, // darkModeTileBuilder
        ),
      ],
    );
  }

  Widget _lightModeTileBuilder(
      BuildContext context,
      Widget tileWidget,
      TileImage tile,
      ) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        1, 0, 0, 0, 0,  // Red channel
        0, 1, 0, 0, 0,  // Green channel
        0, 0, 1, 0, 0,  // Blue channel
        0, 0, 0, 1, 0,  // Alpha channel
      ]),
      child: tileWidget,
    );
  }

  Widget _grayModeTileBuilder(
      BuildContext context,
      Widget tileWidget,
      TileImage tile,
      ) {
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

  Widget _darkenedModeTileBuilder(
      BuildContext context,
      Widget tileWidget,
      TileImage tile,
      ) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        0.75, 0,    0,    0, 0,
        0,    0.75, 0,    0, 0,
        0,    0,    0.75, 0, 0,
        0,    0,    0,    1, 0
      ]),
      child: tileWidget,
    );
  }

  Widget _nightModeTileBuilder(
      BuildContext context,
      Widget tileWidget,
      TileImage tile,
      ) {
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

  void setCoordinate(double latitude, double longitude) {
    _mapController.move(LatLng(latitude, longitude), 15);
  }
}
