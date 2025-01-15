import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ParamedicHomeView extends StatefulWidget {
  const ParamedicHomeView({super.key});

  @override
  _ParamedicHomeViewState createState() => _ParamedicHomeViewState();
}

class _ParamedicHomeViewState extends State<ParamedicHomeView> {
  List<LatLng> routePoints = []; // Lista para almacenar los puntos de la ruta

  @override
  void initState() {
    super.initState();
    fetchRoute(); // Llamar la función para obtener la ruta
  }

  Future<void> fetchRoute() async {
    const String apiKey = 'eaf16749-c66a-43a4-a7e1-cd485a1bca1d';
    const String url = 'https://graphhopper.com/api/1/route';
    const LatLng start = LatLng(10.0, -84.0); // Punto de inicio
    const LatLng end = LatLng(10.1, -84.1); // Punto de destino

    try {
      final response = await http.get(
        Uri.parse(
            '$url?point=${start.latitude},${start.longitude}&point=${end.latitude},${end.longitude}&profile=car&locale=en&calc_points=true&key=$apiKey'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> points = data['paths'][0]['points']['coordinates'];

        setState(() {
          // Convertir los puntos a LatLng y actualizar la lista
          routePoints = points.map((point) => LatLng(point[1], point[0])).toList();
        });
      } else {
        throw Exception('Error al obtener la ruta: ${response.statusCode}');
      }
    } catch (e) {
      print('Error de conexión: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error de Conexión'),
          content: const Text('No se pudo establecer conexión con GraphHopper.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

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
              options: MapOptions(
                initialCenter: LatLng(10.0, -84.0),
                maxZoom: 16.0, // Ajuste opcional de zoom máximo
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png", // URL corregida
                  subdomains: const ['a', 'b', 'c'],
                ),
                // Capa de marcador
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(10.0, -84.0),
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                    Marker(
                      point: LatLng(10.1, -84.1), // Punto de destino
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.green,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                // Capa de polilínea para mostrar la ruta
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: routePoints, // Lista de puntos de la ruta
                      strokeWidth: 4.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Emergencias recientes
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
                  // Lista de emergencias
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.warning, color: Colors.red),
                            title: Text('Emergencia #${index + 1}'),
                            subtitle: Text('Ubicación: Lat ${10.0 + index}, Lng ${-84.0 + index}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.arrow_forward, color: Colors.blue),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EmergencyDetailsView(
                                      emergencyIndex: index + 1,
                                    ),
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

/// Vista para mostrar los detalles de una emergencia específica.
class EmergencyDetailsView extends StatelessWidget {
  final int emergencyIndex;

  const EmergencyDetailsView({super.key, required this.emergencyIndex});

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
