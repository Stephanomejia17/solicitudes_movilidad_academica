import 'package:flutter_test/flutter_test.dart';
import 'package:solicitudes_movilidad_academica/main.dart';

void main() {
  testWidgets('muestra el flujo de autenticacion al iniciar', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Iniciar sesion'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Registro'), findsOneWidget);
  });
}
