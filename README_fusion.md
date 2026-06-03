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

Lo que está documentado/implementado como comportamiento:
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
2. Solicitud en `estado == 'borrador'` y `bloqueada == false`.
3. Debe existir `universidadDestinoId`, `programaAcademico` y `semestre > 0`.
4. Documentos requeridos:
   - `carta_motivacion`
   - `documento_identidad`

### Regla de revisión por coordinador (`canReview`)
En `RequestWorkflowService.canReview()`:
- Actor debe ser `rol == 'coordinador'` y `estado == 'activo'`.
- Solicitud en `estado == 'enviada'` o `estado == 'en_revision'`.

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

### Reglas adicionales por rol (documentación por módulo)
- **Estudiante**: enviar solo en `borrador` sin bloqueo.
- **Coordinador**: aprobar/rechazar solicitudes revisables; rechazo con motivo.
- **Administrador**: gestiona usuarios y auditoría con `HistorialEstadoData`.

## Estados de negocio

### Estados de usuario
- `inactivo`
- `activo`

`RootView` dirige a `PendingApprovalPage` cuando `user.estado == 'inactivo'` (`lib/main.dart`).

### Estados de solicitud
- `borrador` → `enviada` → `aprobada` / `rechazada`
- `cancelada` (contemplado en `cancelarSolicitud()` en `lib/data/app_database.dart`)

Auxiliares:
- `bloqueada`: evita edición cuando corresponde.
- `pendingSync`: offline-first.

### Decisiones del coordinador
- `decision == 'aprobada'`
- `decision == 'rechazada'`

## Flujo principal

### 1) Autenticación y ruteo por rol
1. `main()` inicializa Firebase (cuando aplica) y crea `AppDatabase`.
2. `AuthService.initialize()` escucha `authStateChanges()` y cachea usuario.
3. `RootView` decide pantalla:
   - `user == null` → `AuthPage`
   - `user.estado == 'inactivo'` → `PendingApprovalPage`
   - `rol == 'administrador'` → `AdminDashboardPage`
   - `rol == 'coordinador'` → `CoordinatorDashboardPage`
   - en otro caso → `StudentDashboardPage`

### 2) Estudiante
- Crea/edita en `borrador`.
- Carga documentos requeridos.
- Envía (valida con `canSubmit`), pasa a `enviada` y queda `bloqueada`.

### 3) Coordinador
- Revisa solicitudes (valida `canReview`).
- Aprueba/rechaza; genera `Aprobacion` y actualiza estado/bloqueo.

### 4) Administrador
- Gestiona usuarios (rol/estado).
- Auditoría en historial.

## Explicación de autenticación
Implementada en `lib/features/auth/services/auth_service.dart`:
- **Register**: crea usuario, lo deja `estado: 'inactivo'`, hace `upsertUser()` y cachea local.
- **Login**: autentica, busca perfil en Firestore y bloquea si `remoteUser.estado != 'activo'`.
- Cache local del usuario autenticado.

UI de entrada: `AuthPage`.

## Explicación de roles y permisos
- `AccessPolicy` define habilitaciones base por `rol`.
- El acceso operativo se determina con `RootView` y las reglas de dominio en `RequestWorkflowService`.

## Explicación de persistencia local
- `AppDatabase` (Drift/SQLite) guarda la operación principal.
- `pendingSync` marca entidades pendientes para sincronización.
- Auditoría en `HistorialEstado`.

## Explicación de sincronización con Firebase
- Sincronización **best-effort**.
- Si falla, se preserva local y se reintenta con `pendingSync`.

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

4. Tests (evidencia requerida):
```bash
flutter test
```

5. Ejecutar:
```bash
flutter run
```


## Qué pruebas validan qué

### Lógica de negocio (permisos/estado/transiciones)
- `test/student_application_flow_test.dart`: envío desde `borrador`, reglas de estudiante activo, validación de documentos, bloqueo y historial.
- `test/coordinator_repository_test.dart`: política de revisión, aprobación/rechazo, actualización de estado/bloqueo y validación de motivo.
- `test/admin_repository_test.dart`: normalización/edición, cambios de estado/rol, auditoría e intercambio de pendientes con remoto falso.

### Validaciones de formularios / dominio
- `test/student_application_validators_test.dart`: campos obligatorios, formato de correos, teléfono, semestre y promedio.

### Componentes visuales (UI) y estados
- `test/student_dashboard_widgets_test.dart`: render de banner/resumen y estado offline (“Pendiente de sincronizar”).
- `test/admin_dashboard_widget_test.dart`: render y acción de sincronización en admin.
- `test/coordinator_widget_test.dart`: tabs vacías, navegación a detalle, diálogo de aprobación/rechazo y validación de motivo.
- `test/student_widget_test.dart`: flujo de autenticación al iniciar.

> No se exigen integration tests; las pruebas incluidas cubren unit y widget tests.

## Archivo de reglas de Firestore
- `firestore.rules`

## Documentación técnica por rol
- `docs/student_role_technical.md`
- `docs/coordinator_role_technical.md`
- `docs/admin_role_technical.md`

