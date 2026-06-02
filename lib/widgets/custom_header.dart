import 'package:open_cargo/constantes.dart';
import 'package:open_cargo/controllers/utils/tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/views/auth/notificationes/notificaciones_view.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final TabControllerX controller = Get.find<TabControllerX>();

    return AppBar(
      title: Obx(() => Text(
            controller.titles[controller.selectedIndex.value],
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
             // fontFamily: 'Poppins'
            ),
          )),
      centerTitle: true,
      backgroundColor: ThemeUi.principal,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          onPressed: () {
            Get.to(NotificationView());
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
