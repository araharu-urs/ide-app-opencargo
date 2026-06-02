<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white">
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white">
</picture>

# Open Cargo

Aplicación móvil de gestión logística y transporte construida con **Flutter** y **GetX**. Conecta agencias, transportistas y público en general para la gestión de viajes, ofertas y contratos de carga en tiempo real.

---

## Tecnologías y dependencias

| Paquete | Versión (pubspec) | Versión (lock) | Propósito |
|---|---|---|---|
| `flutter` | SDK | ≥3.27.0 | Framework principal |
| `dart` | SDK | ≥3.7.0-0 <4.0.0 | Lenguaje |
| `get` | ^4.6.6 | 4.6.6 | Estado, navegación, DI |
| `get_storage` | ^2.1.1 | 2.1.1 | Almacenamiento local |
| `flutter_map` | ^6.1.0 | 6.2.1 | Mapas OpenStreetMap |
| `latlong2` | ^0.9.0 | 0.9.1 | Coordenadas geográficas |
| `geolocator` | ^10.1.0 | 10.1.1 | Geolocalización |
| `pusher_channels_flutter` | ^2.2.1 | 2.5.0 | WebSockets en tiempo real |
| `flutter_local_notifications` | ^17.2.3 | 17.2.4 | Notificaciones push locales |
| `permission_handler` | ^11.0.1 | 11.4.0 | Permisos nativos |
| `image_picker` | ^1.1.2 | 1.1.2 | Selección de imágenes |
| `flutter_slidable` | ^3.0.0 | 3.1.2 | Listas deslizables |
| `http` | — | 1.3.0 | Llamadas HTTP (transitivo) |
| `cupertino_icons` | ^1.0.8 | 1.0.8 | Íconos iOS |
| `flutter_launcher_icons` | ^0.13.1 | 0.13.1 | Íconos de app |
| `flutter_lints` | ^5.0.0 | 5.0.0 | Lints recomendados |

---

## Comandos de compilación

| Plataforma | Comando | Notas |
|---|---|---|
| **Android (APK debug)** | `flutter build apk --debug` | APK firmado con debug |
| **Android (APK release)** | `flutter build apk --release` | Requiere keystore configurado |
| **Android (AppBundle)** | `flutter build appbundle` | Para Play Store |
| **iOS (debug)** | `flutter build ios --debug` | Solo simuador |
| **iOS (release)** | `flutter build ios --release` | Requiere Apple Developer |
| **iOS (Archive)** | `flutter build ios --release --no-codesign` | Para TestFlight/App Store |
| **Web** | `flutter build web` | |
| **Linux** | `flutter build linux` | |
| **macOS** | `flutter build macos` | |
| **Windows** | `flutter build windows` | |

### Comandos útiles

| Acción | Comando |
|---|---|
| Limpiar builds | `flutter clean` |
| Obtener paquetes | `flutter pub get` |
| Analizar código | `flutter analyze` |
| Ejecutar tests | `flutter test` |
| Generar icono app | `flutter pub run flutter_launcher_icons` |

---

## Requisitos del sistema

| Requisito | Android | iOS |
|---|---|---|
| **minSdk** | 21 (Android 5.0) | 13.0 (iOS 13+) |
| **targetSdk** | 34 | — |
| **compileSdk** | 35 | — |
| **Permisos** | Ubicación (GPS, red), notificaciones, internet, almacenamiento | Ubicación, notificaciones, tracking |

---

## Arquitectura del proyecto

Patrón **GetX** con separación en capas: **Views → Controllers → Services → API**.

```
lib/
├── bindings/           # Inyección de dependencias por ruta
│   ├── auth/           #   login, register, reset_password
│   ├── public/         #   home, agencia, transporte
│   └── utils/          #   tab_binding
├── controllers/        # Lógica de negocio y estado reactivo
│   ├── auth/           #   login, register, reset_password
│   ├── public/         #   home, chat
│   ├── user/           #   notification_token
│   ├── utils/          #   tab_controller (navegación inferior)
│   └── viajes/         #   viajes (CRUD, ofertas, negociaciones)
├── middleware/          # Guards de navegación
│   ├── auth_middleware  #   Redirige si no hay sesión
│   └── role_middleware  #   Restringe rutas según rol
├── models/             # Modelos de datos (JSON ↔ Objeto)
│   ├── auth/           #   login, login_response, reset_password
│   ├── chat/           #   mensaje, resumen, info
│   ├── user/           #   user, roles
│   └── viajes/         #   viaje, detalle, oferta, negociación
├── routes/             # Definición de rutas y páginas GetX
│   ├── app_routes.dart #   Constantes de ruta
│   └── app_pages.dart  #   Mapeo ruta → página + binding + middleware
├── services/           # Llamadas a API y lógica de red
│   ├── api/            #   headers HTTP (token JWT)
│   ├── auth/           #   login, registro
│   ├── chat/           #   mensajes, chats
│   ├── permisos/       #   permisos nativos
│   ├── users/          #   usuarios, roles, token notificación
│   └── viajes/         #   viajes, ofertas, negociaciones
├── utils/              # Utilidades
│   ├── localitacion/   #   Traducciones EN/ES
│   ├── notifications/  #   Servicio de notificaciones
│   ├── pusher/         #   WebSockets Pusher
│   ├── tabs/           #   BottomNavigationBar dinámico
│   └── theme_controller #   Tema claro/oscuro
├── views/              # Pantallas y widgets de UI
│   ├── auth/           #   login, register, reset_password
│   │   ├── acerca/     #   Sobre app, soporte
│   │   ├── cuenta/     #   Perfil, cambiar password
│   │   ├── login/      #   Formulario, header, footer
│   │   ├── notificationes/
│   │   ├── preferencias/#  Apariencia, notificaciones
│   │   ├── register/   #   Formulario con tabs de perfil
│   │   ├── reset_password/
│   │   ├── seguridad/  #   Privacidad, configuraciones
│   │   └── user/       #   Agencia, transporte, profile, settings
│   └── public/         #   Home (mapa + lista), profile
├── widgets/            # Widgets reutilizables
│   ├── custom_header   #   AppBar con notificaciones
│   ├── no_data_found   #   Empty state
│   └── exceptions/     #   Modals: error, success, loader, confirmación
├── constantes.dart     #   Colores y constantes de UI
├── env.dart            #   Config (baseUrl, Pusher keys)
└── main.dart           #   Punto de entrada
```

---

## Roles de usuario

| Rol | Ruta principal | Descripción |
|---|---|---|
| **Agencia** | `/agencia` | Gestiona viajes y recibe ofertas |
| **Transporte** | `/transporte` | Realiza ofertas de carga |
| **Público** | `/publico` | Visor general del mapa |

Cada rol tiene acceso a las pestañas: **Home**, **Profile** y **Settings**.

---

## API endpoints

La app apunta a un **backend Laravel** alojado en:

```
# Desarrollo (local)
http://192.168.1.104:8003/api/v1

# Producción (comentado)
https://app-open-cargo-183ad5eb9c94.herokuapp.com/api/v1
```

### Autenticación

| Método | Endpoint | Descripción |
|---|---|---|
| `POST` | `/auth/login` | Inicio de sesión, retorna JWT |
| `POST` | `/auth/register` | Registro de nuevo usuario |

### Usuarios

| Método | Endpoint | Descripción |
|---|---|---|
| `GET` | `/users/all` | Lista todos los usuarios |
| `GET` | `/roles/all` | Lista los roles disponibles |
| `POST` | `/users/token-notificacion` | Registra token de notificación |

### Viajes y ofertas

| Método | Endpoint | Descripción |
|---|---|---|
| `GET` | `/viajes/all` | Todos los viajes disponibles |
| `GET` | `/viajes/user/{id}` | Viajes de un usuario |
| `POST` | `/viajes` | Crear un nuevo viaje |
| `GET` | `/viajes/{id}/ofertas` | Ofertas de un viaje |
| `GET` | `/viajes/ofertas/{id}/detalle` | Detalle de una oferta |
| `GET` | `/viajes/{id}/detalle` | Detalle de un viaje |
| `POST` | `/viajes/crearOferta` | Crear oferta sobre un viaje |
| `PUT` | `/ofertas/{id}/aceptar` | Aceptar oferta |
| `PUT` | `/ofertas/{id}/rechazar` | Rechazar oferta |
| `GET` | `/negociaciones/{userId}/viajes` | Ofertas en proceso por usuario |
| `GET` | `/negociaciones/{id}/detalle/{userId}` | Detalle de negociación |

### Chat en tiempo real

| Método | Endpoint | Descripción |
|---|---|---|
| `GET` | `/chats/{userId}` | Lista de chats del usuario |
| `GET` | `/chats/messages/{chatId}` | Mensajes de un chat |
| `GET` | `/chats/{chatId}/{userId}/info` | Información del chat |
| `POST` | `/chats/send-message` | Enviar mensaje (texto/imagen) |

**Autenticación:** Todas las rutas protegidas usan `Authorization: Bearer {token}` (JWT almacenado en GetStorage).

**WebSockets (Pusher):** Canales suscritos para notificaciones en tiempo real y mensajes nuevos de chat.

---

## Características principales

- **Mapa interactivo** con flutter_map (OpenStreetMap) y geolocalización
- **Autenticación JWT** con persistencia en GetStorage
- **3 roles** con navegación dinámica (BottomNavigationBar por rol)
- **CRUD de viajes** con ofertas y contador de contenedores
- **Sistema de ofertas** (Ofertar / Tomar Carga) con flujo de aceptación/rechazo
- **Chat en tiempo real** con Pusher WebSockets
- **Notificaciones push locales** agrupadas por canal
- **Tema claro/oscuro** persistente
- **Internacionalización** EN/ES con GetX Translations
- **Middleware de autenticación y roles** para control de acceso
- **Modal widgets** reutilizables (error, éxito, loader, confirmación)

---

## Configuración del entorno

Edita `lib/env.dart` para cambiar la URL base y credenciales de Pusher:

```dart
class Env {
  static const String baseUrl = 'http://192.168.1.104:8003/api/v1';
  static const String pusherApiKey = 'dd397792af1cef922ffe';
  static const String pusherCluster = 'us2';
}
```

---

## Configuración de firma Android

Crea un archivo `android/key.properties`:

```properties
storeFile=/Users/tu-usuario/ruta/al/keystore.jks
storePassword=tu_password
keyAlias=tu_alias
keyPassword=tu_password
```

El `build.gradle` ya está configurado para leer este archivo automáticamente.

---

## Licencia

© 2025 Open Cargo. Todos los derechos reservados.
