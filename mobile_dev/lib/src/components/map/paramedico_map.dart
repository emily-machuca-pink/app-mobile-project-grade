import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mobile_dev/src/services/location_service.dart';

class EmergenciasListView extends StatelessWidget {
  final List<Emergencia> emergencias = [
    Emergencia(
      id: 1,
      nombre: "Emergencia 1",
      ubicacion: LatLng(10.986847, -74.8195107),
      descripcion: "Accidente de tráfico",
    ),
    Emergencia(
      id: 2,
      nombre: "Emergencia 2",
      ubicacion: LatLng(10.991147, -74.8215107),
      descripcion: "Asalto en la calle",
    ),
    // Agregar más emergencias
  ];

  EmergenciasListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergencias Disponibles'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: emergencias.length,
        itemBuilder: (context, index) {
          final emergencia = emergencias[index];
          return ListTile(
            title: Text(emergencia.nombre),
            subtitle: Text(emergencia.descripcion),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EmergencyRouteView(emergencia: emergencia),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Emergencia {
  final int id;
  final String nombre;
  final LatLng ubicacion;
  final String descripcion;

  Emergencia({
    required this.id,
    required this.nombre,
    required this.ubicacion,
    required this.descripcion,
  });
}

class EmergencyRouteView extends StatefulWidget {
  final Emergencia emergencia;

  const EmergencyRouteView({super.key, required this.emergencia});

  @override
  _EmergencyRouteViewState createState() => _EmergencyRouteViewState();
}

class _EmergencyRouteViewState extends State<EmergencyRouteView> {
  List<LatLng> routePoints = [];
  List<String> navigationInstructions = [];
  late LatLng _currentLocation = const LatLng(10.9827583, -74.8101591);
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getCurrentLocation());
  }

  Future<void> getCurrentLocation() async {
    LatLng? currentLocation = await LocationService.getCurrentLocation();
    if (currentLocation != null) {
      setState(() {
        _currentLocation = currentLocation;
      });
      fetchRoute();
    } else {
      _showErrorDialog('No se pudo obtener la ubicación.');
    }
  }

  Future<void> fetchRoute() async {
    const String apiKey = '9bf13d47-9f64-44a4-889b-519620b3ab16';
    const String url = 'https://graphhopper.com/api/1/route';

    final Map<String, dynamic> body = {
      "points": [
        [_currentLocation.longitude, _currentLocation.latitude],
        [
          widget.emergencia.ubicacion.longitude,
          widget.emergencia.ubicacion.latitude
        ]
      ],
      "profile": "car",
      "locale": "es",
      "calc_points": true,
      "points_encoded": false,
      "instructions": true
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
          final List<dynamic> points =
              data["paths"][0]["points"]["coordinates"];
          final List<dynamic> instructions = data["paths"][0]["instructions"];

          setState(() {
            routePoints =
                points.map((point) => LatLng(point[1], point[0])).toList();
            navigationInstructions =
                instructions.map((inst) => inst["text"].toString()).toList();
          });
        } else {
          throw Exception("No se encontraron rutas disponibles.");
        }
      } else {
        throw Exception('Error al obtener la ruta: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  Future<void> speakInstructions() async {
    for (String instruction in navigationInstructions) {
      await flutterTts.speak(instruction);
      await Future.delayed(Duration(seconds: 3));
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
        title: Text('Ruta a ${widget.emergencia.nombre}'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: _currentLocation,
                maxZoom: 16.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(markers: [
                  Marker(
                    point: _currentLocation,
                    child: const Icon(Icons.location_on,
                        color: Colors.red, size: 30),
                  ),
                  Marker(
                    point: widget.emergencia.ubicacion,
                    child: const Icon(Icons.location_on,
                        color: Colors.green, size: 30),
                  ),
                ]),
                PolylineLayer(polylines: [
                  Polyline(
                    points: routePoints,
                    strokeWidth: 4.0,
                    color: Colors.blue,
                  ),
                ]),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                fetchRoute().then((_) => speakInstructions());
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Iniciar'),
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: navigationInstructions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.directions, color: Colors.blue),
                  title: Text(navigationInstructions[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
