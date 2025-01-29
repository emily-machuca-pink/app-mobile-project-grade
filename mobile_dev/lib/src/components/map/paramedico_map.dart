import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class ParamedicHomeView extends StatefulWidget {
  const ParamedicHomeView({super.key});

  @override
  _ParamedicHomeViewState createState() => _ParamedicHomeViewState();
}

class _ParamedicHomeViewState extends State<ParamedicHomeView> {
  List<LatLng> routePoints = [];
  late LatLng _currentLocation = const LatLng(10.9827583, -74.8101591);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getCurrentLocation());
  }

  // Función para obtener la ubicación actual
  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si el servicio de ubicación está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showErrorDialog('El servicio de ubicación está deshabilitado.');
      return;
    }

    // Verificar permisos de ubicación
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showErrorDialog('Los permisos de ubicación están denegados.');
        return;
      }
    }

    // Obtener la ubicación
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });

    fetchRoute(); // Llamar a fetchRoute después de obtener la ubicación
  }

  // Función para obtener la ruta desde la ubicación actual hasta el destino
  Future<void> fetchRoute() async {
    const String apiKey = '9bf13d47-9f64-44a4-889b-519620b3ab16'; // 🔒 Usa dotenv si es posible
    const String url = 'https://graphhopper.com/api/1/route';

    // Coordenadas del destino
    const LatLng end = LatLng(10.986847, -74.8195107);

    final Map<String, dynamic> body = {
      "points": [
        [_currentLocation.longitude, _currentLocation.latitude], // Ubicación actual
        [end.longitude, end.latitude]
      ],
      "profile": "car",
      "locale": "es",
      "calc_points": true,
      "points_encoded": false
    };

    try {
      final response = await http.post(
        Uri.parse('$url?key=$apiKey'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["paths"] != null && data["paths"].isNotEmpty) {
          final List<dynamic> points = data["paths"][0]["points"]["coordinates"];

          setState(() {
            // Convertimos la lista de coordenadas en puntos LatLng
            routePoints = points.map((point) => LatLng(point[1], point[0])).toList();
          });
        } else {
          throw Exception("No se encontraron rutas disponibles.");
        }
      } else {
        throw Exception('Error al obtener la ruta: ${response.statusCode}');
      }
    } catch (e) {
      print('Error de conexión: $e');
      _showErrorDialog(e.toString());
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error de Conexión'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio - Paramédico'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: _currentLocation ?? LatLng(10.9827583, -74.8101591), // Usamos la ubicación actual
                maxZoom: 16.0,
              ),
              children: [
                // Capa de mapas de OpenStreetMap
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),

                // Marcadores de inicio y destino
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentLocation,
                      child: const Icon(Icons.location_on, color: Colors.red, size: 30),
                    ),
                    const Marker(
                      point: LatLng(10.986847, -74.8195107),
                      child: Icon(Icons.location_on, color: Colors.green, size: 30),
                    ),
                  ],
                ),

                // Dibuja la línea de la ruta obtenida de la API
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: routePoints, // Aquí usamos los puntos de la API
                      strokeWidth: 4.0,
                      color: Colors.blue, // Azul para representar la ruta
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Botón para iniciar la navegación
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: fetchRoute,
              child: const Text('Iniciar'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
          ),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.warning, color: Colors.red),
                            title: Text('Emergencia #${index + 1}'),
                            subtitle: Text('Ubicación: Lat ${10.9827583 + index * 0.001}, Lng ${-74.8101591 + index * 0.001}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.arrow_forward, color: Colors.blue),
                              onPressed: () {
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
          'Información de emergencia #$emergencyIndex',
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
