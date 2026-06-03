# Mejoras Pendientes — Open Cargo App

Elementos identificados durante el análisis del módulo de login (IDE-31) que no se implementaron en la fase activa. Se trasladan aquí para no bloquear fases más importantes.

---

## Auth / Login

### B5 — Rutas incorrectas para roles transporte y publico
`AppRoutes.transporte` y `AppRoutes.publico` apuntan a `/agencia` en lugar de sus rutas propias.
- **Archivo:** `lib/routes/app_routes.dart` y `lib/routes/app_pages.dart`
- **Impacto:** Usuarios con rol transporte o publico ven la pantalla de agencia.

### B7 — Sin validación de formulario antes del login
El botón de login llama a `controller.login()` sin verificar que los campos no estén vacíos ni que el email tenga formato válido. El error llega del backend en lugar de mostrarse localmente.
- **Archivo:** `lib/controllers/auth/login/login_controller.dart`
- **Impacto:** UX pobre; peticiones innecesarias al API con campos vacíos.

---

## Auth / Register

### B10 — `AuthService.register()` sin uso
Existe un método `register()` en `AuthService` que no se usa. El registro real lo hace `RegistroService`. El método muerto genera confusión sobre cuál servicio usar.
- **Archivo:** `lib/services/auth/auth_service.dart`
- **Acción sugerida:** Eliminar el método o eliminar `AuthService` si ya no tiene otros usos.

### B11 — Logout duplicado / redundante
Hay lógica de logout en más de un lugar. Requiere auditoría para consolidar en un único punto.
- **Acción sugerida:** Centralizar en un método en `AuthService` o `LoginController`.

---

## Notas
- Estos ítems no son bloqueantes para las fases activas.
- Revisarlos antes de la primera release en producción.
