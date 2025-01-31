//
//  Copyright © 2025 Proyecto de grado. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class LocationInfo extends StatelessWidget {
  final LatLng location;

  const LocationInfo({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'Ubicación actual:\nLat: ${location.latitude.toStringAsFixed(4)}\nLng: ${location.longitude.toStringAsFixed(4)}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
