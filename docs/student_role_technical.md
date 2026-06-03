# Documentacion tecnica - Rol Estudiante

Esta guia describe unicamente el flujo del rol Estudiante en la aplicacion de solicitudes de movilidad academica.

## Alcance funcional

El estudiante puede iniciar sesion, consultar su portal, crear borradores de solicitud, editarlos mientras sigan en estado `borrador`, cargar documentos requeridos, enviar la solicitud y consultar el historial del proceso. Una vez enviada, la solicitud queda bloqueada para edicion.

## Mapa tecnico

- Dart y Flutter: la implementacion del rol vive en `lib/features/student`.
- Widgets y componentes visuales: `student_dashboard_widgets.dart` contiene banner, tarjetas de estado, resumen de solicitud, secciones de detalle, estados vacios y etiquetas de estado.
- Layouts: las pantallas usan `Scaffold`, `ListView`, `Wrap`, `Card`, `NavigationBar`, `Stepper` y layouts responsivos simples.
- Navegacion entre pantallas: `StudentDashboardPage` abre `StudentApplicationFormPage` para crear y `StudentApplicationDetailPage` para consultar o editar.
- Manejo de estado: `AppStateScope` expone `AppDatabase` como `InheritedNotifier`; las pantallas escuchan streams de Drift con `StreamBuilder`.
- Formularios y validaciones: `StudentApplicationFormPage` usa `Form`, `TextFormField`, `DropdownButtonFormField`, selectores de fecha y validadores de `student_application_validators.dart`.
- Modelado de datos: la solicitud, documentos, usuario, universidades e historial se modelan en Drift (`app_database.dart`) y en modelos Firestore compartidos (`shared/models`).
- Firebase Authentication: el rol autenticado llega desde `AuthService`; si el usuario no es administrador ni coordinador, `RootView` lo dirige al portal Estudiante.
- Cloud Firestore: `StudentFirestoreService` sube solicitudes y documentos a `mobilityRequests`, consulta solicitudes del estudiante por id/correos y descarga documentos remotos.
- Persistencia local: Drift guarda solicitudes, documentos, universidades e historial en SQLite local.
- Sincronizacion local/remota: `StudentApplicationRepository` coordina subida de pendientes, descarga remota y limpieza de documentos ausentes.
- Offline-first: las operaciones del estudiante escriben primero en Drift, marcan `pendingSync` y reintentan sincronizacion cuando Firestore falla.
- Estados de UI: se muestran estados vacios, cargando, etiquetas de estado (`borrador`, `enviada`, `aprobada`, etc.) e indicador `Pendiente de sincronizar`.
- Unit tests: `test/student_application_validators_test.dart` cubre validadores y `test/student_application_flow_test.dart` cubre reglas locales del flujo Estudiante.
- Widget tests: `test/student_dashboard_widgets_test.dart` cubre componentes visuales del dashboard/detalle Estudiante.

## Reglas del flujo Estudiante

- Solo un usuario con rol `estudiante` y estado `activo` puede enviar una solicitud.
- Solo las solicitudes en `borrador` y sin bloqueo se pueden editar.
- Para enviar se requiere universidad destino, programa academico, semestre mayor a cero, carta de motivacion y documento de identidad.
- Al enviar, la solicitud cambia de `borrador` a `enviada`, queda `bloqueada` y se registra historial.
- Los documentos requeridos no se pueden duplicar dentro de la misma solicitud.
- Los cambios locales quedan con `pendingSync = true` hasta completar sincronizacion remota.

## Comandos utiles

Ejecutar analisis estatico:

```sh
dart analyze
```

Ejecutar pruebas:

```sh
flutter test
```

Generar APK Android:

```sh
flutter build apk --release
```

El APK generado queda normalmente en `build/app/outputs/flutter-apk/app-release.apk`.
