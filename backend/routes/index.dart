// En otro archivo, como user_repository.dart
import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  // Aquí manejarías la solicitud, posiblemente accediendo a una base de datos o algo similar.
  return Response.json(body: {'message': 'Hello from user repository!'});
}
