# Bugs Backlog

Documento de identificación de bugs potenciales y conocidos basado en evidencia del código fuente revisado.

## Riesgos técnicos detectados

- Reglas de Firestore abiertas a lectura y escritura global.
- API key de Firebase embebida en el código para la creación de usuarios desde el módulo administrativo.

- Ausencia de pipeline de CI/CD visible en el repositorio.
- Linux no está configurado en `DefaultFirebaseOptions`.
- La app depende en gran medida de validaciones del lado cliente para permisos y flujo de trabajo.

## Deuda técnica

- Falta estrategia de observabilidad centralizada para errores de sincronización.
- Falta una capa explícita de auditoría de seguridad sobre cambios críticos.
- Falta automatización E2E.
- Falta endurecimiento de secretos y configuración de entorno.


## Mejoras recomendadas

- Externalizar secretos y eliminar llaves de API del código fuente.
- Introducir logging estructurado para errores de sync.
- Agregar pruebas de integración para sincronización remota.
- Definir pipeline de release con validación de build, tests y seguridad.

## Backlog De Bugs

| ID | Título | Descripción | Impacto | Prioridad | Severidad | Módulo afectado | Pasos para reproducir | Resultado esperado | Resultado actual | Estado | Responsable | Fecha |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
 BUG-001 | Linux no configurado para Firebase | `DefaultFirebaseOptions.currentPlatform` lanza `UnsupportedError` para Linux. | La app no inicia en Linux. | P2 | Media | `lib/firebase_options.dart` | 1. Ejecutar la app en Linux. | Firebase inicializa o existe fallback documentado. | Se lanza error de plataforma no soportada. | Abierto | Pendiente de asignación | 2026-06-03 |
| BUG-002 | Sincronización sin trazabilidad de fallo | Varios métodos capturan errores remotos y continúan sin persistir causa ni contexto. | Dificulta soporte y diagnóstico. | P1 | Alta | `StudentApplicationRepository`, `CoordinatorRepository`, `AdminRepository` | 1. Forzar falla de Firestore. 2. Ejecutar sync. | Se registra el motivo y el contexto del error. | El error se ignora o se reduce a comentario. | Abierto | Pendiente de asignación | 2026-06-03 |
| BUG-003 | Validación de permisos centrada en cliente | El flujo de acceso depende de `currentUser.rol` y validaciones locales. | Riesgo de escalamiento de privilegios si el cliente es manipulado. | P0 | Crítica | `main.dart`, `access_policy.dart`, repositorios de rol | 1. Alterar estado local o payload remoto. 2. Navegar por rol. | Autorización reforzada por backend/reglas. | El control principal está en cliente. | Abierto | Pendiente de asignación | 2026-06-03 |
| BUG-004 | Carga documental sin adjunto real | El diálogo de documentos solicita solo el nombre del archivo, no un archivo o binario real. | Inconsistencia funcional si se esperaba gestión documental completa. | P2 | Alta | `lib/features/student/pages/student_application_detail_page.dart` | 1. Abrir solicitud en borrador. 2. Cargar documento. | Selección y almacenamiento real del archivo. | Solo se registra el nombre del archivo. | Abierto | Pendiente de asignación | 2026-06-03 |
 BUG-005 | Sin pipeline de build y release visible | No hay archivos de CI/CD en el repositorio para build, test y despliegue. | Riesgo operativo en liberaciones. | P2 | Media | Repositorio completo | 1. Revisar `.github/`, scripts y pipelines. | Existe pipeline reproducible. | No se evidencia pipeline de release. | Abierto | Pendiente de asignación | 2026-06-03 |
| BUG-006 | Validación de integridad remota parcial | La sincronización descarta conflictos y prioriza estado local sin resolución explícita. | Posibles desalineaciones entre local y Firestore. | P1 | Alta | `StudentApplicationRepository`, `CoordinatorRepository`, `AdminRepository` | 1. Modificar local y remoto simultáneamente. 2. Sincronizar. | Resolución determinística de conflictos. | La resolución no está definida explícitamente. | Abierto | Pendiente de asignación | 2026-06-03 |
| BUG-007 | Falta confirmación de build iOS/Android en repo | El proyecto incluye configuración nativa, pero no evidencia de validación automatizada de release. | Riesgo de ruptura en entrega. | P2 | Media | `android/`, `ios/` | 1. Ejecutar build release. 2. Revisar resultados. | Builds reproducibles y validados. | Pendiente de validación en el código fuente. | Abierto | Pendiente de asignación | 2026-06-03 |

## Notas

- Los ítems anteriores combinan bugs observables y riesgos técnicos materializados en el código actual.
- Cuando un caso no puede confirmarse en ejecución por falta de entorno, se indica como pendiente de validación en el código fuente.
