import 'package:flutter_test/flutter_test.dart';
import 'package:solicitudes_movilidad_academica/features/student/validators/student_application_validators.dart';

void main() {
  group('validadores del formulario de estudiante', () {
    test('exige valores obligatorios', () {
      expect(validateRequired(null), isNotNull);
      expect(validateRequired('   '), isNotNull);
      expect(validateRequired('Laura'), isNull);
    });

    test('valida correos institucionales y personales', () {
      expect(validateEmail('laura.gomez@udem.edu.co'), isNull);
      expect(validateEmail('correo-invalido'), 'Ingresa un correo valido.');
      expect(validateEmail(''), 'Este campo es obligatorio.');
    });

    test('valida telefono con longitud permitida', () {
      expect(validatePhone('300 123 4567'), isNull);
      expect(validatePhone('123'), 'Ingresa un telefono valido.');
      expect(validatePhone(''), 'Este campo es obligatorio.');
    });

    test('valida semestre y promedio academico', () {
      expect(validatePositiveNumber('7'), isNull);
      expect(validatePositiveNumber('0'), 'Ingresa un numero mayor a cero.');
      expect(validatePositiveNumber('abc'), 'Ingresa un numero mayor a cero.');

      expect(validateAverage('4,3'), isNull);
      expect(validateAverage('5.1'), 'Ingresa un promedio entre 0 y 5.');
      expect(validateAverage('-1'), 'Ingresa un promedio entre 0 y 5.');
    });
  });
}
