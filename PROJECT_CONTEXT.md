# Open Cargo App — Contexto del Proyecto

Documento de continuidad. Úsalo al retomar el proyecto para entender en qué estado quedó todo y qué sigue.

---

## Stack técnico

- **Flutter + Dart** SDK ^3.6.1
- **GetX** — estado reactivo (`obs`), navegación (`Get.toNamed`), DI (`Get.put` / `Get.find`)
- **GetStorage** — persistencia local (token, id, rol, nombre, correo)
- **flutter_map 6.2.1** — mapas con OpenStreetMap
- **Pusher Channels** — WebSockets para tiempo real
- **flutter_local_notifications** — notificaciones locales
- **Backend** — Laravel en Heroku: `https://app-open-cargo-183ad5eb9c94.herokuapp.com/api/v1`
- **Dev local** — `http://10.0.2.2:8000/api/v1` (emulador Android → host localhost)

---

## Linear (trazabilidad)

- **Proyecto App:** Open Cargo App — https://linear.app/urahara/project/open-cargo-app-a129151ae63b
- **Proyecto Backend:** Open Cargo Backend — https://linear.app/urahara/project/open-cargo-backend-f2bd0cb37ef7
- **Team:** Idevart
- **Documento de diseño:** IDE-36 — [Design Base] UI Design System & Component Guidelines

Reglas de Linear:
- Nueva funcionalidad → Issue `[Phase N]`
- Cambio mayor a algo documentado → Issue `[V2]`
- Cambio menor → comentario en el Issue existente
- Todo en **inglés**

---

## Arquitectura de la app

```
GetX pattern:
Views → Controllers → Services → API

Flujo de datos:
- Services: solo HTTP, retornan data o null. NUNCA muestran UI.
- Controllers: reciben la data, manejan estado y muestran snackbars / modales.
- Views: solo construyen UI, llaman métodos del controller.
```

### Persistencia local (GetStorage)
| Clave | Contenido |
|---|---|
| `token` | JWT de acceso |
| `id` | ID del usuario |
| `rol` | Rol del usuario (lowercase: agencia, transporte, publico) |
| `nombre` | Nombre del usuario |
| `correo` | Email del usuario |
| `token_notificacion` | FCM token para push notifications |

### Roles aceptados por la app
`agencia` · `transporte` · `publico`

> El rol viene del backend en minúsculas. El middleware lo normaliza con `.toLowerCase().trim()` antes de comparar.

---

## Pantallas implementadas / estado actual

### Auth / Login (`lib/views/auth/login/`)

**Estado:** Rediseño completo terminado (Fase 3 + 4).

Layout:
```
Scaffold(resizeToAvoidBottomInset: false)
└── Stack
    ├── Gradient full-screen (ThemeUi.principal → purpleAccent)
    ├── Header 36% — logo (assets/icon.png), "Open Cargo", subtitle i18n
    └── Tarjeta blanca flotante 68% — borderRadius top 28
        └── SingleChildScrollView
            ├── LoginForm — email, password + toggle, forgot, botón gradiente, skip
            └── LoginFooter — "¿No tienes cuenta? Sign Up"
```

Archivos clave:
- `login_view.dart` — estructura Stack, sin AppBar
- `widgets/login_form.dart` — inputs estilizados, toggle contraseña, botón gradiente
- `widgets/login_footer.dart` — fila inline "Don't have an account? Sign Up"
- `widgets/login_header.dart` — vacío (contenido migrado a login_view.dart)
- `controllers/auth/login/login_controller.dart` — email, password, isLoading, obscurePassword
- `services/auth/login/login_service.dart` — POST /auth/login, escribe GetStorage, retorna null en error

Bugs corregidos en esta sesión:
- URL del backend apuntaba a IP local incorrecta → corregido a `10.0.2.2:8000`
- `RoleMiddleware` comparaba sin normalizar → agregado `.toLowerCase().trim()`
- `login_service.dart` mostraba ErrorModal → eliminado, ahora retorna null
- GetStorage escribía `rol` en los campos `nombre` y `correo` → corregido
- Teclado empujaba el layout → `resizeToAvoidBottomInset: false`
- Double ErrorModal al inicio → eliminado de `users_service.dart`

---

### Auth / Register (`lib/views/auth/register/`)

**Estado:** Rediseño completo terminado (Fase 5).

Layout idéntico al login:
```
Scaffold(resizeToAvoidBottomInset: false)
└── Stack
    ├── Gradient full-screen
    ├── Header 30% — back arrow (Get.back()), logo, "Open Cargo", "Crea tu cuenta"
    └── Tarjeta blanca flotante 74% — borderRadius top 28
        └── SingleChildScrollView(
              padding: fromLTRB(20, 28, 20, viewInsets.bottom + 20))
            ├── Título "Registro" + subtítulo
            ├── Selector de perfiles (chips horizontales, ThemeUi.principal)
            ├── Campos: nombre, email, [empresa, RFC condicional], password, confirmar
            ├── Botón gradiente "Registrarse"
            └── Footer "¿Ya tienes cuenta? Iniciar sesión"
```

Comportamiento de teclado en Register:
- `resizeToAvoidBottomInset: false` — la tarjeta no sube entera
- `viewInsets.bottom` como padding inferior del ScrollView — Flutter auto-scrollea al campo enfocado, sube solo lo necesario

Archivos clave:
- `register_view.dart` — estructura Stack completa, usa `Get.find<RegisterController>()`
- `widgets/input_text.dart` — `buildTextField()` con estilo unificado al login
- `widgets/tabs_profile.dart` — chips de perfil con `ThemeUi.principal`
- `controllers/auth/register/register_controller.dart` — agrega `obscurePassword`, `obscureConfirm`

---

### Public / Home (`lib/views/public/home/`)

**Estado:** Funcional con fix de MapController.

Bug corregido:
- `LateInitializationError` en `mapController.move()` — flutter_map 6.x inicializa `_internalController` solo cuando `FlutterMap` está montado
- Fix: mover `_getCurrentLocation()` de `onInit()` a `onReady()` + `addPostFrameCallback` + try/catch

```dart
@override
void onReady() {
  super.onReady();
  _getCurrentLocation();
}
// Dentro de _getCurrentLocation():
WidgetsBinding.instance.addPostFrameCallback((_) {
  try {
    mapController.move(currentPosition.value, 15.0);
  } catch (_) {}
});
```

---

## Sistema de diseño (IDE-36)

Todos los detalles en Linear IDE-36. Resumen:

| Token | Valor |
|---|---|
| Color principal | `ThemeUi.principal` = `Color(0xFF3605FA)` |
| Gradiente | `ThemeUi.principal` → `Colors.purpleAccent` |
| Fill inputs (light) | `Colors.grey[200]` — NO usar grey[50], se pierde sobre fondo blanco |
| Fill inputs (dark) | `Colors.grey[800]` |
| Border focus | `ThemeUi.principal`, width 1.5 |
| Border radius inputs | 12 |
| Border radius botón CTA | 12 |
| Altura botón CTA | 52px |
| Font | Poppins (Bold 700 títulos, Regular 400 body, 13px labels) |
| Padding horizontal pantalla | 20px |

Patrones obligatorios en pantallas auth:
- Sin AppBar
- Stack: gradiente full-screen + tarjeta flotante con `borderRadius top 28`
- `resizeToAvoidBottomInset: false` siempre
- Formularios largos: `viewInsets.bottom` como padding del ScrollView

---

## Archivos de configuración importantes

| Archivo | Propósito |
|---|---|
| `lib/env.dart` | URLs base del backend (cambiar entre dev y prod) |
| `lib/constantes.dart` | `ThemeUi.principal` y colores del tema |
| `lib/middleware/role_middleware.dart` | Protege rutas por rol, normaliza a lowercase |
| `lib/routes/app_routes.dart` | Constantes de rutas — **ver bug B5 pendiente** |
| `lib/utils/localitacion/translations.dart` | Claves i18n en_US y es_ES |
| `android/app/src/main/AndroidManifest.xml` | `android:enableOnBackInvokedCallback="true"` ya agregado |
| `pubspec.yaml` | Assets registrados: `assets/icon.png` |

### Cambiar entre dev y prod
```dart
// lib/env.dart
// Dev (emulador Android):
static const String baseUrl = 'http://10.0.2.2:8000/api/v1';
// Prod:
static const String baseUrl = 'https://app-open-cargo-183ad5eb9c94.herokuapp.com/api/v1';
```

---

## Issues en Linear — Estado final de esta sesión

| Issue | Título | Estado |
|---|---|---|
| IDE-30 | [Planning] Login Module — Full Analysis | Done |
| IDE-31 | [Phase 1] Login Module — Bug Fixes | Done |
| IDE-32 | [Planning] Map Controller Fix | Done |
| IDE-33 | [Planning] Login Screen Redesign | Done |
| IDE-34 | [Phase 3] Login — Header & Layout | Done |
| IDE-35 | [Phase 4] Login — Form & Footer Polish | Done |
| IDE-36 | [Design Base] UI Design System | Done |
| IDE-37 | [Planning] Register Screen Redesign | Done |
| IDE-38 | [Phase 5] Register Screen Redesign | Done |

---

## Mejoras pendientes

Ver `PENDING_IMPROVEMENTS.md` en la raíz del proyecto. Resumen:

| ID | Descripción | Archivo |
|---|---|---|
| B5 | `AppRoutes.transporte` y `.publico` apuntan a `/agencia` | `lib/routes/app_routes.dart` |
| B7 | Sin validación de formulario en login (campos vacíos) | `lib/controllers/auth/login/login_controller.dart` |
| B10 | `AuthService.register()` es código muerto | `lib/services/auth/auth_service.dart` |
| B11 | Logout duplicado/redundante | `lib/services/auth/auth_service.dart` |

---

## Qué sigue (sugerencias para la próxima sesión)

1. **Pantalla Reset Password** — aplicar el mismo diseño (gradiente + tarjeta flotante), siguiendo IDE-36
2. **Validación de formularios** — login y registro (B7), antes de la primera release
3. **Corregir B5** — `AppRoutes.transporte` y `.publico` con rutas correctas
4. **Limpiar AuthService** — eliminar `register()` muerto y simplificar `logout()` (B10, B11)
5. **Probar en dispositivo físico** — cambiar `env.dart` a la URL de Heroku y verificar flujo completo
