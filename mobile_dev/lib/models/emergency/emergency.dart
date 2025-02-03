//
//  Copyright © 2025 Proyecto de grado. All rights reserved.
//

import 'package:latlong2/latlong.dart';

/// Representa una emergencia en el sistema.
class Emergencia {
  /// Identificador único de la emergencia.
  final int id;

  /// Nombre de la emergencia.
  final String nombre;

  /// Ubicación de la emergencia representada por coordenadas geográficas.
  final LatLng ubicacion;

  /// Descripción detallada de la emergencia.
  final String descripcion;

  Emergencia({
    required this.id,
    required this.nombre,
    required this.ubicacion,
    required this.descripcion,
  });
}
