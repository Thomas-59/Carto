import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  final bool isDarkMode;

  const MapWidget({super.key, required this.isDarkMode});

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
        minZoom: 5,
        maxZoom: 15,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
          tileBuilder:  widget.isDarkMode ? darkModeTileBuilder : _lightModeTileBuilder,
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
        1.2, 0, 0, 0, 0,  // Red channel
        0, 1.2, 0, 0, 0,  // Green channel
        0, 0, 1.2, 0, 0,  // Blue channel
        0, 0, 0, 1, 0,    // Alpha channel
      ]),
      child: tileWidget,
    );
  }

  void setCoordinate(double latitude, double longitude) {
    _mapController.move(LatLng(latitude, longitude), 15);
  }
}
