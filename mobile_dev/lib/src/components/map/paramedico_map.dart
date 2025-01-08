import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ParamedicHomeView extends StatelessWidget {
  const ParamedicHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio - Paramédico'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Mapa con GraphHopper
          Expanded(
            flex: 2,
            child: FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(10.0, -84.0), // Coordenadas iniciales (ajustar según necesidad)
                maxZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(10.0, -84.0), // Coordenadas de ejemplo
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Emergencias
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Emergencias recientes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5, // Número de emergencias (ajustar dinámicamente)
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.warning, color: Colors.red),
                            title: Text('Emergencia #${index + 1}'),
                            subtitle: Text('Ubicación: Lat ${10.0 + index}, Lng ${-84.0 + index}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.arrow_forward, color: Colors.blue),
                              onPressed: () {
                                // Acción al presionar una emergencia
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EmergencyDetailsView(emergencyIndex: index + 1),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmergencyDetailsView extends StatelessWidget {
  final int emergencyIndex;

  const EmergencyDetailsView({Key? key, required this.emergencyIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de Emergencia #$emergencyIndex'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Información detallada de la emergencia #$emergencyIndex',
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
