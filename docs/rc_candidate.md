# Release Candidate

Documento de referencia para candidato de liberación.

## Información De Versión

| Campo | Valor |
|---|---|
| Versión | `1.0.0+1` |
| Fecha | `2026-06-03` |
| Responsable | Pendiente de validación en el código fuente |
| Branch origen | Pendiente de validación en el código fuente |

## Cambios Incluidos

### Nuevas funcionalidades

- Autenticación con Firebase.
- Segmentación por rol para estudiante, coordinador y administrador.
- Panel de estudiante con creación, edición, detalle y envío de solicitudes.
- Revisión de solicitudes por coordinador con aprobación y rechazo.
- Gestión administrativa de usuarios.
- Persistencia local con Drift.
- Sincronización con Firestore en modo offline-first.

### Correcciones

- Persistencia local estructurada por entidades.
- Validadores de formulario para correo, teléfono, semestre y promedio.
- Bloqueo de solicitudes cuando pasan a estado final.

### Mejoras

- Estado reactivo con `StreamBuilder`.
- Separación por feature.
- Normalización de modelos entre local y remoto.
- Historial de cambios de estado.

## Validaciones Realizadas

| Validación | Estado | Evidencia |
|---|---|---|
| Build Android | Pendiente de validación en el entorno | `flutter` no está disponible en esta sesión |
| Build iOS | Pendiente de validación en el entorno | Requiere entorno macOS/Xcode |
| Smoke Test | Parcial | Revisión de flujo de arranque y pantallas principales en código fuente |
| Regression Test | Parcial | Existen pruebas unitarias y de widget, pero no se ejecutaron en esta sesión |
| Seguridad | No aprobada | `firestore.rules` está abierto y hay API key embebida |

## Riesgos Conocidos

- Reglas de Firestore demasiado permisivas.
- Secretos embebidos en el código.
- Sincronización sin resolución explícita de conflictos.
- Linux no configurado en Firebase options.
- Falta de automatización E2E.

## Problemas Abiertos

| ID | Problema | Estado |
|---|---|---|
| RC-001 | Endurecimiento de reglas Firestore | Abierto |
| RC-002 | Externalización de secretos | Abierto |
| RC-003 | Validación de build release Android | Abierto |
| RC-004 | Validación de build release iOS | Abierto |
| RC-005 | Cobertura E2E | Abierto |

## Aprobaciones

| Rol | Responsable | Estado |
|---|---|---|
| Desarrollo | Pendiente de asignación | Pendiente |
| QA | Pendiente de asignación | Pendiente |
| Seguridad | Pendiente de asignación | Pendiente |
| Producto | Pendiente de asignación | Pendiente |
| Operaciones | Pendiente de asignación | Pendiente |

## Observaciones

- Este documento no sustituye la validación técnica de build y despliegue.
- No debe liberarse a producción sin corregir los hallazgos de seguridad.
