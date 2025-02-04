// server.dart
import 'package:dart_frog/dart_frog.dart'; // Importación correcta de dart_frog

Future<void> main() async {
  final router = Router()
    // Definir las rutas y sus correspondientes respuestas
    ..get('/user_repository', (context) => Response.json(body: {'message': 'Hello from user repository!'}))
    ..get('/', (context) => Response.json(body: {'message': 'Hello from root!'}));

  // Pipeline: Añadir middleware para registrar las solicitudes
  final handler = Pipeline()
      .addMiddleware(logRequests()) // Middleware para registrar las solicitudes
      .addHandler(router); // Se añaden las rutas definidas

  // Inicia el servidor en el puerto deseado
  await serve(handler, 'localhost', 8080); // Cambia 'localhost' y el puerto si lo necesitas
}

// Middleware personalizado para registrar solicitudes
Middleware logRequests() {
  return (handler) {
    return (context) async {
      // Registrar detalles de la solicitud
      print('Solicitud: ${context.request.method} ${context.request.uri}');
      // Llamar al siguiente middleware o controlador
      return await handler(context);
    };
  };
}
