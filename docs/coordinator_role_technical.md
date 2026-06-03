# Documentacion tecnica - Coordinador

## Alcance funcional

El coordinador ingresa al portal CoordinatorDashboardPage, ve un resumen operativo de solicitudes con pestañas para todas, en revisión, aprobadas y rechazadas, puede abrir el detalle de cada solicitud, leer la información académica y de contacto, consultar aprobaciones registradas y aprobar o rechazar solicitudes. Las acciones de aprobación y rechazo solo están disponibles para solicitudes en estado enviada; al aprobar se permite comentario opcional y al rechazar se exige motivo obligatorio.

## Mapa tecnico

### Estructura de carpetas

La implementación del rol vive en `lib/features/coordinator`, separada en `pages`, `services` y `domain`.

### Widgets y componentes visuales

`CoordinatorDashboardPage` define `_StatCard`, `_SolicitudList` y `_StatusChip`, mientras `CoordinatorSolicitudDetailPage` define `_HeaderCard`, `_SectionCard`, `_DetailRow` y `ReviewDialog`.

### Layouts

Las pantallas usan `Scaffold`, `AppBar`, `DefaultTabController`, `TabBar`, `TabBarView`, `ListView`, `Wrap`, `Card`, `ListTile`, `Chip` y diálogos de Material.

### Navegacion entre pantallas

`CoordinatorDashboardPage` navega con `Navigator.push` hacia `CoordinatorSolicitudDetailPage` pasando el `solicitudId` y el `CoordinatorRepository`.

### Manejo de estado

`AppStateScope` entrega `AppDatabase`, `AuthServiceScope` entrega `AuthService` y las pantallas renderizan datos reactivos con `StreamBuilder`.

### Formularios y validaciones

`ReviewDialog` usa `Form`, `TextFormField` y `GlobalKey<FormState>` para validar que el rechazo tenga motivo, y `CoordinatorReviewPolicy` valida el permiso real antes de aprobar o rechazar.

### Modelado de datos

El flujo usa `SolicitudMobilidadData`, `AprobacionData` y `UsuarioData` de Drift, y los transforma a `SolicitudMovilidadModel` y `AprobacionModel` para Firestore.

### Firebase Authentication

`RootView` dirige a `CoordinatorDashboardPage` cuando `currentUser.rol == 'coordinador'`, y el cierre de sesión se ejecuta con `AuthService.logout`.

### Cloud Firestore

`CoordinatorFirestoreService` lee y escribe en `FirestoreCollections.mobilityRequests` y en la subcolección `FirestoreCollections.approvals`.

### Persistencia local

`CoordinatorRepository` consulta solicitudes con `watchSolicitudes`, obtiene detalle con `watchSolicitud` y guarda aprobaciones en la tabla Drift `aprobacion`.

### Sincronizacion local/remota

`syncSolicitud` sube la solicitud y sus aprobaciones con `upsertSolicitudBundle`, marca registros como sincronizados y descarga la versión remota de la solicitud.

### Offline-first

Si falla la sincronización remota en `syncSolicitud` o `syncDown`, el repositorio captura el error y conserva los datos locales con `pendingSync`.

### Estados de UI

El dashboard muestra carga, error, estados vacíos por pestaña, conteos por estado y etiquetas para enviada, aprobada, rechazada y otros estados.

### Unit tests

`test/coordinator_repository_test.dart` cubre `CoordinatorReviewPolicy`, conteos, aprobación, rechazo y sincronización pendiente.

### Widget tests

`test/coordinator_widget_test.dart` cubre carga, estados vacíos, navegación al detalle, botón de sincronización, logout, validación del diálogo y SnackBars de éxito/error.

## Reglas del flujo

- Solo un usuario con `rol == 'coordinador'` y `estado == 'activo'` puede revisar solicitudes.
- Solo una solicitud con `estado == 'enviada'` puede aprobarse o rechazarse.
- Si la solicitud no existe en la base local, `approve` y `reject` lanzan `StateError`.
- Al aprobar, se crea un registro `AprobacionData` con `decision == 'aprobada'`, `coordinadorId`, `usuarioId`, `fechaDecision` y `pendingSync == true`.
- Al aprobar, la solicitud cambia a `estado == 'aprobada'`, queda `bloqueada == true`, actualiza `fechaActualizacion` y queda con `pendingSync == true`.
- Si la aprobación no incluye comentario, se registra el comentario por defecto `Solicitud aprobada por el coordinador.`
- Al rechazar, el motivo es obligatorio y un valor vacío o compuesto solo por espacios lanza `ArgumentError`.
- Al rechazar, se crea un registro `AprobacionData` con `decision == 'rechazada'` y el motivo normalizado como comentario.
- Al rechazar, la solicitud cambia a `estado == 'rechazada'`, queda `bloqueada == true`, actualiza `fechaActualizacion` y queda con `pendingSync == true`.
- `syncPending` sincroniza cada solicitud con `pendingSync == true` y cada aprobación pendiente asociada a una solicitud.
- La descarga remota no sobrescribe una solicitud local ni una aprobación local cuando el registro local tiene `pendingSync == true`.

## Comandos utiles

### Ejecutar analisis estatico

```bash
dart analyze
```

### Ejecutar pruebas

```bash
flutter test
```

### Generar APK Android

```bash
flutter build apk --release
```

APK generado en:

```text
build/app/outputs/flutter-apk/app-release.apk
```

### Generar build iOS

```bash
flutter build ios --release
```

Requiere Mac con Xcode.