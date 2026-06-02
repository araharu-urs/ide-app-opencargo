import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:open_cargo/constantes.dart';

class NotificationItem {
  final String title;
  final String message;
  bool isRead;

  NotificationItem(
      {required this.title, required this.message, this.isRead = false});
}

class NotificationController extends GetxController {
  RxList<NotificationItem> notifications = <NotificationItem>[
    NotificationItem(
        title: "Nuevo viaje disponible",
        message: "Se ha publicado un nuevo viaje."),
    NotificationItem(
        title: "Tu carga fue aceptada",
        message: "El transportista ha aceptado tu carga."),
    NotificationItem(
        title: "Recordatorio", message: "Tienes una cita pendiente mañana."),
    NotificationItem(
        title: "Nuevo viaje disponible",
        message: "Se ha publicado un nuevo viaje."),
    NotificationItem(
        title: "Tu carga fue aceptada",
        message: "El transportista ha aceptado tu carga."),
    NotificationItem(
        title: "Recordatorio", message: "Tienes una cita pendiente mañana."),
  ].obs;

  void markAsRead(int index) {
    notifications[index].isRead = true;
    notifications.refresh();
  }
}

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController controller = Get.put(NotificationController());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notificaciones"),
        centerTitle: true,
        backgroundColor: ThemeUi.principal,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return const Center(child: Text("No tienes notificaciones"));
        }

        return ListView.builder(
          itemCount: controller.notifications.length,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          itemBuilder: (context, index) {
            final notif = controller.notifications[index];

            return Slidable(
              key: ValueKey(index),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (_) => controller.markAsRead(index),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    icon: Icons.done,
                    label: "Leído",
                  ),
                ],
              ),
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: notif.isRead ? 1 : 3,
                color: notif.isRead
                    ? theme.cardColor.withOpacity(0.8)
                    : theme.colorScheme.surface,
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  leading: CircleAvatar(
                    backgroundColor: notif.isRead
                        ? Colors.grey[300]
                        : theme.primaryColor.withOpacity(0.2),
                    child: Icon(
                      notif.isRead
                          ? Icons.notifications_none
                          : Icons.notifications,
                      color: notif.isRead ? Colors.grey : theme.primaryColor,
                    ),
                  ),
                  title: Text(
                    notif.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: notif.isRead
                          ? Colors.grey[600]
                          : theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  subtitle: Text(
                    notif.message,
                    style: TextStyle(
                      fontSize: 14,
                      color: notif.isRead
                          ? Colors.grey[500]
                          : theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                  trailing: notif.isRead
                      ? const Icon(Icons.check, color: Colors.green, size: 20)
                      : const SizedBox.shrink(),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
