import 'dart:io';

import 'package:carto/models/establishment.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

/// A utilitarian class
class IntentUtils {
  IntentUtils._();

  /// Launch an extern app to navigate the user to a chosen establishment
  static Future<void> launchNavigation(
      BuildContext context,
      Establishment establishment
  ) async {
    final encodedAddress = Uri.encodeComponent(establishment.address);

    final Uri googleMapsWebUri = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$encodedAddress'
            '&travelmode=driving'
    );

    final Uri googleMapsWalkingWebUri = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$encodedAddress'
            '&travelmode=walking'
    );

    final Uri wazeUri =
        Uri.parse('https://waze.com/ul?q=$encodedAddress&navigate=yes');

    final Uri appleMapsUri = Uri.parse('applemaps://?q=$encodedAddress');

    final Map<String, Uri> apps = {
      'Google Maps Car': googleMapsWebUri,
      'Google Maps Walking': googleMapsWalkingWebUri,
      'Waze': wazeUri,
    };

    // Add AppleMaps to list of Uris if the platform is iOS
    if (Platform.isIOS) {
      apps['Apple Maps'] = appleMapsUri;
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: apps.entries.map((entry) {
              return ListTile(
                leading: Icon(
                  entry.key.startsWith('Google Maps')
                      ? Icons.map
                      : Icons.navigation,
                ),
                title: Text(entry.key),
                onTap: () async {
                  Navigator.pop(context);
                  if (await canLaunchUrl(entry.value)) {
                    await launchUrl(
                      entry.value,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Impossible d\'ouvrir ${entry.key}.'),
                      ),
                    );
                  }
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
