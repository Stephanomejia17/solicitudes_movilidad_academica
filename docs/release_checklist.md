# Release Checklist

Checklist de liberación para la aplicación de solicitudes de movilidad académica.

## Desarrollo

- [ ] Código revisado por pares.
- [ ] Linter ejecutado sin errores.
- [ ] Tests unitarios exitosos.
- [ ] Tests de widget exitosos.
- [ ] Revisión de dependencias completada.
- [ ] Versionado actualizado en `pubspec.yaml`.

## QA

- [ ] Casos de prueba ejecutados para estudiante.
- [ ] Casos de prueba ejecutados para coordinador.
- [ ] Casos de prueba ejecutados para administrador.
- [ ] Evidencias adjuntas.
- [ ] Prueba de regresión completada.
- [ ] Smoke test completado.
- [ ] Prueba sin conexión completada.

## Seguridad

- [ ] Secretos removidos del código fuente.
- [ ] Reglas Firestore verificadas y restringidas.
- [ ] Roles validados también en backend o reglas.
- [ ] No se exponen credenciales en logs.
- [ ] Se revisó el acceso a datos sensibles.

## Android

- [ ] Build Release ejecutado.
- [ ] Firma APK/AAB verificada.
- [ ] Verificación de `google-services.json`.
- [ ] Validación de instalación en dispositivo real.
- [ ] Revisión de publicación en Play Store.

## iOS

- [ ] Build Release ejecutado.
- [ ] Certificados y provisioning profiles válidos.
- [ ] Verificación de `GoogleService-Info.plist`.
- [ ] Validación en dispositivo real.
- [ ] Prueba de distribución en TestFlight.

## Producción

- [ ] Deploy ejecutado.
- [ ] Monitoreo activo.
- [ ] Alertas configuradas.
- [ ] Procedimiento de rollback definido.
- [ ] Confirmación de sincronización post-despliegue.
- [ ] Validación final de permisos y acceso.

## Observaciones

- Si algún ítem queda pendiente, no liberar a producción.
- Antes del go-live, confirmar que el flujo por rol no presenta regresiones.
