# Solicitudes de Movilidad Académica

## Nombre del proyecto
**Solicitudes de Movilidad Académica**

## Descripción del problema
Gestionar solicitudes de movilidad académica con:
- flujo de aprobación por roles (estudiante → coordinador → aprobada/rechazada),
- trazabilidad de cambios (historial de estados y decisiones),
- operación **offline-first** (persistencia local + sincronización best-effort con Firebase),
- control de acceso por **rol** y **estado de cuenta** (activo/inactivo).

## Integrantes del equipo
Stephano Mejia, Melissa Foronda y Nathalida Velez

## Roles implementados
- `estudiante`
- `coordinador`
- `administrador`

La navegación se decide con el rol y estado actual del usuario en `RootView` (`lib/main.dart`).

## Usuarios de prueba
**Estudiante:** `tepho3@gmail.com`  
**Coordinador:** `stephano.mejia20@icloud.com`  
**Administrador:** `stephano.mejia900@gmail.com`  

Todas las cuentas tienen como contraseña: `123456789`

Lo que sí está documentado/implementado como comportamiento:
- Un usuario registrado desde autenticación se crea con `estado = inactivo` y no puede operar hasta ser activado.
- El login bloquea usuarios cuyo estado remoto no sea `activo`.

Además, el sistema siembra datos demo locales de **universidades destino** cuando la base local está vacía (`_seedDemoDataIfNeeded()` en `lib/data/app_database.dart`).

## Entidades principales

### Persistencia local (Drift / SQLite)
Tablas en `lib/data/app_database.dart`:
- **`Usuarios`**: `id`, `nombre`, `apellido`, `email`, `rol`, `estado`, `pendingSync`, `createdAt`, `updatedAt`
- **`SolicitudMovilidad`**: solicitud del estudiante (campos académicos/contacto + `estado`, `bloqueada`, `pendingSync`, fechas)
- **`UniversidadDestino`**: catálogo de destinos (`convenioActivo`, `pendingSync`)
- **`Documento`**: documentos requeridos por solicitud (`tipoDocumento`, `nombreArchivo`, `estado`, `pendingSync`)
- **`Aprobacion`**: decisiones del coordinador por solicitud (`decision`, `comentario`, `fechaDecision`, `pendingSync`)
- **`HistorialEstado`**: auditoría de cambios (estado anterior/nuevo por solicitud o por usuario)

### Correspondencia conceptual en Firestore
Colecciones en `lib/shared/services/firestore_collections.dart`:
- `usuarios`
- `historial_usuarios`
- `mobility_requests`
- `aprobaciones`
- `documentos`

## Explicación del modelo en Firestore
El repositorio remoto utiliza `FirestoreCollections` para mapear entidades:

- **Usuarios**: se escriben/actualizan desde `UserFirestoreService` (`lib/features/auth/services/user_firestore_service.dart`).
  - `upsertUser()` hace `set(..., merge: true)` en `usuarios/{uid}`.
  - Se normaliza el rol al formato remoto:
    - `estudiante` → `student`
    - `coordinador` → `coordinator`
    - `administrador` → `admin`
  - Se agregan campos como `syncedAt` (serverTimestamp) y una bandera `isActive`.

- **Solicitudes y aprobaciones**:
  - `mobility_requests` guarda la solicitud.
  - `aprobaciones` guarda decisiones.

- **Documentos**:
  - `documentos` guarda metadatos por solicitud (localmente se persiste `tipoDocumento`, `nombreArchivo`, etc.).

## Reglas de negocio

### Regla de envío de solicitud (Student → `canSubmit`)
Definidas en `RequestWorkflowService.canSubmit()` (`lib/shared/services/request_workflow_service.dart`):
1. Actor debe ser `rol == 'estudiante'` y `estado == 'activo'`.
2. La solicitud debe estar en `estado == 'borrador'` y `bloqueada == false`.
3. Debe existir `universidadDestinoId`, `programaAcademico` y `semestre > 0`.
4. Documentos requeridos:
   - debe existir `carta_motivacion`
   - debe existir `documento_identidad`

### Regla de revisión por coordinador (`canReview`)
En `RequestWorkflowService.canReview()`:
- Actor debe ser `rol == 'coordinador'` y `estado == 'activo'`.
- La solicitud debe estar en `estado == 'enviada'` o `estado == 'en_revision'`.

### Aprobación (`approve`)
En `RequestWorkflowService.approve()`:
- `estado = 'aprobada'`
- `bloqueada = true`
- `fechaActualizacion = now`
- `pendingSync = true`

### Rechazo (`reject`)
En `RequestWorkflowService.reject()`:
- exige `comentario.trim().isNotEmpty`
- `estado = 'rechazada'`
- `bloqueada = true`
- `pendingSync = true`

### Reglas adicionales por rol
- **Estudiante**: enviar solo si está en `borrador` y no está bloqueada; al enviar pasa a `enviada` y queda bloqueada.
- **Coordinador**: puede aprobar/rechazar solicitudes revisables; crea `AprobacionData` y actualiza el estado de la solicitud.
- **Administrador**: gestiona usuarios (rol/estado) y auditabilidad con `HistorialEstadoData`.

## Estados de negocio

### Estados de usuario
- `inactivo`
- `activo`

`RootView` dirige a `PendingApprovalPage` cuando `user.estado == 'inactivo'`.

### Estados de solicitud
- `borrador` → (enviar) → `enviada` → (approve/reject) → `aprobada` / `rechazada`
- `cancelada` (contemplado en `cancelarSolicitud()`)

Auxiliares:
- `bloqueada`: evita edición cuando corresponde.
- `pendingSync`: usado para offline-first.

### Decisiones del coordinador
- `decision == 'aprobada'`
- `decision == 'rechazada'`

## Flujo principal

### 1) Autenticación y ruteo por rol
1. `main()` inicializa Firebase (cuando aplica) y crea `AppDatabase`.
2. `AuthService.initialize()` escucha `authStateChanges()` y cachea usuario en local.
3. `RootView` decide pantalla:
   - `user == null` → `AuthPage`
   - `user.estado == 'inactivo'` → `PendingApprovalPage`
   - `rol == administrador` → `AdminDashboardPage`
   - `rol == coordinador` → `CoordinatorDashboardPage`
   - en otro caso → `StudentDashboardPage`

### 2) Estudiante
- Crea/edita solicitud en `borrador`.
- Carga documentos requeridos.
- Envía (valida con `canSubmit`), pasa a `enviada` y queda `bloqueada`.

### 3) Coordinador
- Revisa solicitudes (solo si `canReview`).
- Aprueba o rechaza.
- Se registra `Aprobacion` y se actualiza estado/bloqueo.

### 4) Administrador
- Gestiona usuarios (crear/editar/rol/estado).
- Los cambios quedan auditados en historial.

## Explicación de autenticación
Implementada en `lib/features/auth/services/auth_service.dart`:
- **Register**: crea usuario con Firebase Auth, lo deja `estado: 'inactivo'`, hace `upsertUser()` en Firestore y cachea local.
- **Login**: autentica con Firebase Auth, busca el perfil en Firestore, y si `remoteUser.estado != 'activo'` bloquea el acceso.
- **Sincronización de perfil**: cachea el usuario autenticado en el local.

UI de entrada: `AuthPage`.

## Explicación de roles y permisos
- `AccessPolicy` da habilitaciones base.
- La navegación final y el acceso operativo se determinan en `RootView` y en validaciones de dominio con `RequestWorkflowService`.

## Explicación de persistencia local
- Se usa `AppDatabase` (Drift/SQLite).
- La app escribe primero en local y marca entidades con `pendingSync`.
- Auditoría en `HistorialEstado` (solicitudes y usuarios).

## Explicación de sincronización con Firebase
- Sincronización **best-effort**.
- Si falla la subida/bajada, se preserva local y se reintenta usando `pendingSync`.

## Instrucciones para ejecutar el proyecto

1. Clonar:
```bash
cd solicitudes_movilidad_academica
```

2. Instalar dependencias:
```bash
flutter pub get
```

3. Análisis estático:
```bash
dart analyze
```

4. Tests:
```bash
flutter test
```

5. Ejecutar:
```bash
flutter run
```

## Archivo de reglas de Firestore
- `firestore.rules`

## Documentación técnica por rol (extra)
- `docs/student_role_technical.md`
- `docs/coordinator_role_technical.md`
- `docs/admin_role_technical.md`

