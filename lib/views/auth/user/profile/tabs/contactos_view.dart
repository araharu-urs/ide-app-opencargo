import 'package:open_cargo/constantes.dart';
import 'package:open_cargo/controllers/public/profile/chat/chat_controller.dart';
import 'package:open_cargo/views/auth/user/profile/chat/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget TabContactos() {
  final ChatController chatController = Get.put(ChatController());

  return Stack(
    children: [
      Obx(() {
        if (chatController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (chatController.chats.isEmpty) {
          return Center(
            child: Text(
              "No tienes chats activos",
              style: TextStyle(
                color: Theme.of(Get.context!).hintColor,
                fontSize: 16,
              ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: chatController.chats.length,
          separatorBuilder: (context, index) => Divider(
            color: Theme.of(context).dividerColor.withOpacity(0.2),
            thickness: 1,
            indent: 60,
            endIndent: 10,
          ),
          itemBuilder: (context, index) {
            final chat = chatController.chats[index];

            return Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Get.to(() => ChatView(chatId: chat.id));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                          child: Text(
                            chat.inicial,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                      chat.nombre,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: Text(
                      chat.ultimoMensaje ?? "No hay mensajes",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                    ),
                    trailing: Text(
                      chat.horaUltimoMensaje ?? "--:--",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),

      // 🔄 Botón flotante para recargar chats
      Positioned(
        bottom: 20,
        right: 20,
        child: FloatingActionButton(
          heroTag: 'recargar_chats',
          backgroundColor: ThemeUi.principal,
          onPressed: () {
            chatController.fetchUserChats();
          },
          child: const Icon(Icons.refresh, color: Colors.white),
        ),
      ),
    ],
  );
}
