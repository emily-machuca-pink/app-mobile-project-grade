//
//  Copyright © 2025 Proyecto de grado. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobile_dev/src/components/emergency/botton_actions.dart';
import 'package:mobile_dev/src/components/emergency/emergency_button.dart';
import 'package:mobile_dev/src/components/emergency/location_info.dart';
import 'package:mobile_dev/src/services/location/location_service.dart';

class EmergencyButtonView extends StatefulWidget {
  const EmergencyButtonView({super.key});

  @override
  _EmergencyButtonViewState createState() => _EmergencyButtonViewState();
}

class _EmergencyButtonViewState extends State<EmergencyButtonView> {
  late LatLng _currentLocation = const LatLng(10.9827583, -74.8101591);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getCurrentLocation());
  }

  Future<void> _getCurrentLocation() async {
    LatLng? currentLocation = await LocationService.getCurrentLocation();
    if (currentLocation != null) {
      setState(() {
        _currentLocation = currentLocation;
      });
    } else {
      _showErrorDialog('No se pudo obtener la ubicación. Verifique los permisos.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error de Ubicación'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _activateEmergency() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Emergencia activada en la ubicación: Lat: ${_currentLocation.latitude}, Lng: ${_currentLocation.longitude}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Emergencia', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            LocationInfo(location: _currentLocation),
            const BottomActions(),
            EmergencyButton(onTap: _activateEmergency),
          ],
        ),
      ),
    );
  }
}
