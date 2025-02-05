// lib/user_repository.dart
import 'package:postgres/postgres.dart'; // Asegúrate de agregar esta dependencia

class User {
  final String id; // Este es el id del usuario (documento)
  final String documento;
  final String password;
  final String tipo; // Puede ser 'paciente' o 'paramedico'

  // Constructor con todos los campos
  User({
    required this.id,
    required this.documento,
    required this.password,
    required this.tipo,
  });
}

class UserRepository {
  final PostgreSQLConnection _connection;

  UserRepository(this._connection);

  // Método para autenticar al usuario con documento y password
  Future<User?> fetchFromCredentials(String documento, String password) async {
    try {
      // Primero intentamos encontrar al paciente
      var result = await _connection.query(
        'SELECT documento, contraseña FROM paciente WHERE documento = @documento',
        substitutionValues: {'documento': documento},
      );

      if (result.isNotEmpty) {
        var row = result.first;
        String storedPassword = row[1].toString(); // Convierte el valor dinámico a String

        if (storedPassword == password) {
          return User(
            id: row[0].toString(), // Convierte el valor dinámico a String
            documento: row[0].toString(), // Convierte el valor dinámico a String
            password: storedPassword,
            tipo: 'paciente',
          );
        }
      }

      // Si no se encontró al paciente, intentamos buscar al paramédico
      result = await _connection.query(
        'SELECT documento, contraseña FROM paramedico WHERE documento = @documento',
        substitutionValues: {'documento': documento},
      );

      if (result.isNotEmpty) {
        var row = result.first;
        String storedPassword = row[1].toString(); // Convierte el valor dinámico a String

        if (storedPassword == password) {
          return User(
            id: row[0].toString(), // Convierte el valor dinámico a String
            documento: row[0].toString(), // Convierte el valor dinámico a String
            password: storedPassword,
            tipo: 'paramedico',
          );
        }
      }
    } catch (e) {
      print('Error al autenticar: $e');
    }

    return null; // Si no se encuentra el usuario o hay un error
  }

  // Método para autenticar con token (si usas JWT u otro método)
  Future<User?> fetchFromAccessToken(String token) async {
    // Aquí puedes implementar lógica para decodificar el token y autenticar a los usuarios
    return null;
  }
}
