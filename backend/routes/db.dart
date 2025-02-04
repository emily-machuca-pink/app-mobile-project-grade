// lib/db.dart
import 'package:postgres/postgres.dart';

Future<PostgreSQLConnection> connectToDatabase() async {
  final connection = PostgreSQLConnection(
    'localhost', // Dirección de la base de datos
    5432, // Puerto
    'backend', // Nombre de la base de datos
    username: 'postgres',
    password: '123456',
  );

  await connection.open();
  return connection;
}
