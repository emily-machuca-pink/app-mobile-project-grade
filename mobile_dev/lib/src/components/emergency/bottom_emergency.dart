import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobile_dev/src/components/medical_folder/medical_folder.dart';
import 'package:mobile_dev/src/services/location_service.dart';
import 'package:mobile_dev/src/views/patient_profile/patient_profile.dart';

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
    // Verificar permisos y obtener ubicación
    LatLng? currentLocation = await LocationService.getCurrentLocation();
    if (currentLocation != null) {
      setState(() {
        _currentLocation = currentLocation;
      });
    } else {
      _showErrorDialog(
          'No se pudo obtener la ubicación. Verifique los permisos.');
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
              'Emergencia activada en la ubicación: Lat: ${_currentLocation.latitude}, Lng: ${_currentLocation.longitude}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Emergencia',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildLocationInfo(),
            _buildBottomActions(context),
            _buildEmergencyButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationInfo() {
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
          'Ubicación actual:\nLat: ${_currentLocation.latitude.toStringAsFixed(4)}\nLng: ${_currentLocation.longitude.toStringAsFixed(4)}',
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

  Widget _buildBottomActions(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon:
                  const Icon(Icons.folder_copy, size: 40, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MedicalFolderView()),
                );
              },
            ),
            const SizedBox(width: 40),
            IconButton(
              icon: const Icon(Icons.person, size: 40, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PatientProfile()),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildEmergencyButton() {
    return Center(
      child: GestureDetector(
        onTap: _activateEmergency,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
            const Text(
              'SOS',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
