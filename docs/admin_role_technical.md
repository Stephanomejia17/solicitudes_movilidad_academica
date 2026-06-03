# Documentacion tecnica - Administrador

## Alcance funcional

El administrador ingresa al portal AdminDashboardPage, ve la gestión de usuarios con el total local, puede crear usuarios, consultar usuarios, editar nombre, apellido, email y rol, activar o desactivar cuentas, consultar historial de cambios y sincronizar datos pendientes. La creación exige nombre, apellido, email válido, contraseña mínima y rol; los cambios de estado y rol quedan auditados, mientras la edición general de usuario no registra historial.

## Mapa tecnico

### Estructura de carpetas

La implementación del rol vive en `lib/features/admin`, organizada en `pages`, `widgets` y `services`.

### Widgets y componentes visuales

`AdminDashboardPage` muestra el resumen de gestión, `UserCard` concentra acciones por usuario y `UserFormDialog` maneja creación y edición.

### Layouts

Las pantallas usan `Scaffold`, `AppBar`, `ListView`, `Card`, `ListTile`, `Chip`, `PopupMenuButton`, `AlertDialog`, `Form` y `SingleChildScrollView`.

### Navegacion entre pantallas

El administrador permanece en `AdminDashboardPage` y abre flujos secundarios con diálogos para crear, editar, confirmar cambio de estado y ver historial.

### Manejo de estado

`AppStateScope` expone `AppDatabase`, `AuthServiceScope` expone `AuthService`, `AdminDashboardPage` usa `StreamBuilder` y los widgets usan `setState` para carga y sincronización.

### Formularios y validaciones

`UserFormDialog` valida nombre, apellido, email con `@`, contraseña obligatoria de mínimo 6 caracteres al crear y selección de rol.

### Modelado de datos

El flujo administra `UsuarioData` e `HistorialEstadoData` de Drift, y normaliza roles remotos entre `estudiante/student`, `coordinador/coordinator` y `administrador/admin`.

### Firebase Authentication

`RootView` dirige a `AdminDashboardPage` cuando `currentUser.rol == 'administrador'`, `AdminRepository.crearUsuario` crea la cuenta con Identity Toolkit y `editarUsuario` intenta `verifyBeforeUpdateEmail` si el usuario actual edita su propio email.

### Cloud Firestore

`AdminFirestoreService` escribe usuarios en `FirestoreCollections.users` e historial en `FirestoreCollections.userHistory`, y consulta usuarios filtrados por `createdBy`.

### Persistencia local

`AdminRepository` usa Drift para `watchUsuarios`, `getUsuarioById`, `upsertUsuarioLocal`, `updateUsuario`, `setUsuarioEstado` y consultas de historial.

### Sincronizacion local/remota

`syncUsuario` sube usuarios, `syncPending` sube usuarios e historiales pendientes, y `sincronizarDesdeFirestore` limpia usuarios locales excepto el admin actual antes de insertar usuarios remotos creados por ese admin.

### Offline-first

`syncUsuario`, `syncPending` y `sincronizarDesdeFirestore` capturan errores remotos para mantener disponible el estado local y reintentar pendientes después.

### Estados de UI

La pantalla muestra carga inicial, indicador de sincronización, SnackBars de éxito/error, conteo total, menú de acciones por usuario e historial vacío cuando no hay registros.

### Unit tests

`test/admin_repository_test.dart` cubre edición con normalización de email, cambio de estado, asignación de rol, descarga remota y sincronización de pendientes.

### Widget tests

`test/admin_dashboard_widget_test.dart` cubre render del dashboard, listado de usuarios y acción de sincronización.

## Reglas del flujo

- Al crear usuario, el email se normaliza con `trim().toLowerCase()` antes de enviarlo a Firebase y guardarlo localmente.
- Al crear usuario, Firebase Identity Toolkit debe devolver `localId`; si no lo devuelve, se lanza `StateError`.
- Si Firebase responde `EMAIL_EXISTS` durante la creación, se lanza una excepción con el mensaje `El email ya está registrado`.
- Todo usuario creado por el administrador se guarda localmente con `estado == 'activo'` y `pendingSync == true`.
- Al crear usuario, se registra historial con `estadoAnterior == ''`, `estadoNuevo == 'activo'`, comentario `Usuario creado` y `registradoPor == createdBy`.
- Al editar usuario, si el usuario no existe en la base local, se lanza `StateError`.
- Al editar usuario, se actualizan nombre, apellido, email normalizado y rol, y el usuario queda con `pendingSync == true` hasta sincronizar.
- La edición general de usuario no registra historial de cambios.
- Al cambiar estado, si el usuario no existe en la base local, se lanza `StateError`.
- Al cambiar estado, se conserva `estadoAnterior`, se guarda `estadoNuevo`, se registra comentario y se crea historial con `registradoPor`.
- Al asignar rol, si el usuario no existe en la base local, se lanza `StateError`.
- Al asignar rol, el historial usa `estadoAnterior == 'rol_${rolAnterior}'`, `estadoNuevo == 'rol_$nuevoRol'` y comentario `Rol asignado: $nuevoRol`.
- `sincronizarDesdeFirestore` elimina usuarios locales excepto el administrador actual antes de insertar usuarios remotos retornados por `traerUsuariosDeAdmin`.
- `syncPending` sincroniza usuarios con `pendingSync == true` e historiales pendientes, y marca cada registro como sincronizado cuando la subida remota termina correctamente.

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