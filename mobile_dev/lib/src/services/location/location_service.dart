//
//  Copyright © 2025 Proyecto de grado. All rights reserved.
//

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  /// Obtiene la ubicación actual del dispositivo.
  static Future<LatLng?> getCurrentLocation() async {
    try {
      // Verificar si el servicio de ubicación está habilitado
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null; // Retorna null si el servicio está deshabilitado
      }

      // Verificar permisos de ubicación
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null; // Retorna null si los permisos siguen siendo denegados
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // El usuario ha denegado los permisos permanentemente
        return null;
      }

      // Obtener la ubicación actual
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      print('Error al obtener la ubicación: $e');
      return null; // Manejo de errores en caso de fallo inesperado
    }
  }

  /// Verifica si los permisos están otorgados y si no, los solicita.
  static Future<bool> requestPermissions() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      return permission == LocationPermission.whileInUse || permission == LocationPermission.always;
    } catch (e) {
      print('Error al solicitar permisos de ubicación: $e');
      return false;
    }
  }

  /// Abre la configuración de la app si los permisos han sido denegados permanentemente.
  static Future<void> openSettings() async {
    await Geolocator.openAppSettings();
  }
}
