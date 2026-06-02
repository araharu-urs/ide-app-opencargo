import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  int _notificationCounter = 1;

  Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Manejar clic en la notificación si es necesario
        debugPrint("🔔 Notificación seleccionada: ${response.payload}");
      },
    );

    // Inicializa zonas horarias
    tz.initializeTimeZones();
    debugPrint("✅ Notificaciones inicializadas");
  }

  Future<void> showNotification(
    int id,
    String title,
    String body, {
    String threadId = 'open_cargo_group',
  }) async {
    const String groupKey = 'com.open_cargo.notifications.group';

    final androidDetails = AndroidNotificationDetails(
      'general_channel',
      'General Notifications',
      channelDescription: 'Canal para notificaciones generales',
      importance: Importance.max,
      priority: Priority.high,
      groupKey: groupKey,
      playSound: true,
      enableVibration: true,
      ticker: 'ticker',
    );

    final iosDetails = DarwinNotificationDetails(
      threadIdentifier: threadId,
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    try {
      // 🔔 Notificación individual
      await _flutterLocalNotificationsPlugin.show(
        _notificationCounter++,
        title,
        body,
        notificationDetails,
      );

      // 🔔 Notificación resumen para Android (solo)
      await _flutterLocalNotificationsPlugin.show(
        0, // ID constante para el resumen
        'Open Cargo',
        'Tienes nuevas notificaciones',
        NotificationDetails(
          android: AndroidNotificationDetails(
            'general_channel',
            'General Notifications',
            channelDescription: 'Resumen de notificaciones',
            styleInformation: const InboxStyleInformation([]),
            groupKey: groupKey,
            setAsGroupSummary: true,
          ),
        ),
      );

      debugPrint("✅ Notificación enviada correctamente");
    } catch (e, stack) {
      debugPrint("❌ Error al mostrar notificación: $e");
      debugPrint("🪵 Stacktrace: $stack");
    }
  }

  Future<void> scheduleNotification(
    int id,
    String title,
    String body,
    DateTime scheduledDate,
  ) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'scheduled_channel',
          'Notificaciones Programadas',
          channelDescription: 'Notificaciones programadas para futuro',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
