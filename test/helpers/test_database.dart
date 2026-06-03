import 'package:drift/native.dart';
import 'package:solicitudes_movilidad_academica/data/app_database.dart';

AppDatabase createTestDatabase() {
  return AppDatabase(NativeDatabase.memory()); // inicializamos la bd de prueba de drift en memoria
}