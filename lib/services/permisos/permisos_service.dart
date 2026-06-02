import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {

final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  /// Solicita todos los permisos necesarios al iniciar la app
  static Future<void> requestInitialPermissions() async {
    await _requestNotificationPermission();
     await requestIOSNotificationPermission();
    await _requestLocationPermissions();
  }

/// ✅ Asegura que iOS tenga el permiso de notificaciones activado
static Future<void> requestIOSNotificationPermission() async {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final bool? granted = await notificationsPlugin
      .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );

  if (granted == true) {
    print('✅ Permiso de notificaciones concedido (iOS)');
  } else {
    print('❌ Permiso de notificaciones denegado (iOS)');
  }
}
  /// 🔔 Solicita permiso para notificaciones
  static Future<void> _requestNotificationPermission() async {
    final status = await Permission.notification.status;
    if (!status.isGranted) {
      final result = await Permission.notification.request();
      if (result.isGranted) {
        print("✅ Permiso de notificaciones concedido");
      } else {
        print("❌ Permiso de notificaciones denegado");
      }
    }
  }

  /// 📍 Solicita permisos de ubicación
  static Future<void> _requestLocationPermissions() async {
    final statusFine = await Permission.location.status;
    if (!statusFine.isGranted) {
      final result = await Permission.location.request();
      if (result.isGranted) {
        print("✅ Permiso de ubicación concedido");
      } else {
        print("❌ Permiso de ubicación denegado");
      }
    }
  }
}
