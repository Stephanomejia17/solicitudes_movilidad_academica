# Plan De Pruebas

Documento de estrategia y cobertura de pruebas para la aplicación de solicitudes de movilidad académica.

## Estrategia De Testing

### Unit Testing

Objetivo:

- validar reglas de negocio,
- validar transformaciones de modelo,
- validar estados y políticas de acceso,
- validar normalización de datos.

### Widget Testing

Objetivo:

- verificar renderizado de pantallas y componentes,
- validar navegación básica,
- comprobar mensajes vacíos, loaders y acciones principales.



## Casos De Prueba Por Módulo

### Módulo: Autenticación

| Caso de prueba | Precondiciones | Datos de entrada | Resultado esperado | Criterio de aceptación |
|---|---|---|---|---|
| Login con credenciales válidas | Usuario existe en Firebase y en cache local | Email y contraseña correctos | Se navega al dashboard según el rol | El usuario queda autenticado y el rol resuelve la pantalla correcta |
| Login con cuenta inactiva | Usuario existe pero estado distinto de `activo` | Email y contraseña correctos | La sesión se cierra y se muestra error de cuenta inactiva | No se permite el acceso al sistema |
| Registro de usuario | Firebase Auth disponible | Nombre, apellido, email, contraseña y rol | Cuenta creada con estado `inactivo` y cache local actualizado | La cuenta queda registrada pero no debe permitir acceso hasta ser activada |
| Logout | Usuario autenticado | Acción de cerrar sesión | Se limpia usuario actual y se retorna al login | La sesión queda cerrada sin estado residual |

### Módulo: Estudiante

| Caso de prueba | Precondiciones | Datos de entrada | Resultado esperado | Criterio de aceptación |
|---|---|---|---|---|
| Validación de campos obligatorios | Formulario abierto | Campos vacíos | Mensajes de error visibles | Ningún formulario avanza con campos requeridos vacíos |
| Validación de correo y teléfono | Formulario abierto | Email inválido y teléfono corto | Errores de validación | Los validadores bloquean datos malformados |
| Crear borrador | Usuario estudiante activo | Datos personales, académicos y de movilidad | Solicitud guardada en estado `borrador` | El borrador aparece en dashboard y detalle |
| Adjuntar documento requerido | Solicitud en borrador | Tipo de documento y nombre de archivo | Documento registrado localmente | El sistema almacena el tipo y el nombre del archivo; no se valida un binario adjunto real |
| Enviar solicitud | Solicitud en borrador con soportes mínimos | Solicitud válida + carta motivación + documento identidad | Estado cambia a `enviada` y queda bloqueada | El envío crea historial y bloquea edición |
| Editar solicitud bloqueada | Solicitud no en borrador | Intento de edición | Operación rechazada | No se modifican solicitudes fuera de borrador |
| Cancelar solicitud | Solicitud no aprobada | Acción cancelar | Estado cambia a `cancelada` | La solicitud queda bloqueada y historizada |

### Módulo: Coordinador

| Caso de prueba | Precondiciones | Datos de entrada | Resultado esperado | Criterio de aceptación |
|---|---|---|---|---|
| Carga de tablero | Base local con solicitudes | Lista variada de estados | Se muestran tarjetas y tabs con conteos | El dashboard no falla y clasifica por estado |
| Revisar solicitud enviada | Usuario coordinador activo | Solicitud en estado `enviada` | Se habilitan aprobar/rechazar | Solo solicitudes enviadas pueden revisarse |
| Aprobar solicitud | Solicitud enviada | Comentario opcional | Estado `aprobada`, bloqueada y aprobada localmente | Se registra aprobación y sincronización pendiente |
| Rechazar solicitud | Solicitud enviada | Motivo obligatorio | Estado `rechazada`, bloqueada y aprobada localmente | El rechazo exige motivo y registra aprobación |
| Ver detalle de aprobación | Existen aprobaciones locales | Solicitud con historial | Se listan aprobaciones ordenadas | La UI muestra trazabilidad de decisiones |

### Módulo: Administrador

| Caso de prueba | Precondiciones | Datos de entrada | Resultado esperado | Criterio de aceptación |
|---|---|---|---|---|
| Ver dashboard de usuarios | Base local con usuarios | Pantalla principal | Se muestra total y tarjetas de usuario | El listado es consistente con Drift |
| Crear usuario | Usuario autenticado con rol admin | Nombre, apellido, email, contraseña, rol | Usuario creado en Auth y Firestore | El nuevo usuario aparece en lista y en remoto con estado local `activo` |
| Editar usuario | Usuario existente | Nombre, apellido, email, rol | Datos actualizados localmente y sincronizados | El sistema normaliza el email y persiste cambios |
| Cambiar estado | Usuario existente | Activar o desactivar | Estado actualizado y registrado en historial | El cambio queda auditado |
| Asignar rol | Usuario existente | Nuevo rol | Rol actualizado y registrado en historial | El cambio queda auditado y sincronizado |

### Módulo: Persistencia Y Sincronización

| Caso de prueba | Precondiciones | Datos de entrada | Resultado esperado | Criterio de aceptación |
|---|---|---|---|---|
| Sincronización pendiente estudiante | Registros con `pendingSync = true` | Solicitudes y documentos locales | Subida remota y marcado sincronizado | No quedan pendientes tras sync exitosa |
| Sincronización pendiente coordinador | Solicitudes con aprobaciones pendientes | Aprobaciones locales | Subida remota y marcado sincronizado | Se conserva consistencia entre tablas |
| Sync offline | Conectividad ausente | Operación de sincronización | La app conserva estado local y reintenta luego | No se pierde información local |
| Descarga remota | Firestore con datos válidos | Usuario actual | Se actualiza cache local sin sobreescribir cambios locales pendientes | La data remota no pisa cambios locales no sincronizados |

## Matriz De Cobertura

| Módulo | Unit | Widget | Integration | E2E |
|---|---|---|---|---|
| Autenticación | Parcial | Sí | No | No |
| Estudiante | Sí | Sí | Parcial | No |
| Coordinador | Sí | Sí | Parcial | No |
| Administrador | Sí | Sí | Parcial | No |
| Persistencia / Sync | Sí | No | Parcial | No |
| Shared / Utilidades | Sí | Parcial | No | No |

## Evidencia De Cobertura Existente

- `test/student_application_validators_test.dart`
- `test/student_application_flow_test.dart`
- `test/student_dashboard_widgets_test.dart`
- `test/coordinator_repository_test.dart`
- `test/coordinator_widget_test.dart`
- `test/admin_repository_test.dart`
- `test/admin_dashboard_widget_test.dart`
- `test/student_widget_test.dart`



## Criterios De Aceptación Global

- El flujo por rol se comporta conforme a las reglas del dominio.
- Las pantallas no presentan errores críticos de renderizado.
- Los estados locales se conservan ante fallas remotas.
- Las validaciones de formulario impiden datos inválidos.
- La sincronización no destruye cambios locales pendientes.
- La seguridad debe quedar corregida antes de producción.
